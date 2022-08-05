class Invoice < ApplicationRecord
    enum status: [:completed, "in progress", :cancelled]

    validates_presence_of :status
    validates_presence_of :created_at
    validates_presence_of :updated_at

    # has_many :invoice_items, dependent: :destroy
    # has_many :transactions, dependent: :destroy
    has_many :items, through: :invoice_items
    belongs_to :customer
    has_many :invoice_items
    has_many :transactions
    has_many :items, through: :invoice_items

    has_many :merchants, through: :items


    def self.incomplete_invoices_not_shipped
      select('invoices.*').distinct.joins(:invoice_items).where.not(invoice_items: {status: 2}).order('created_at ASC')
    end

    # returns invoice items for a specific merchant 

    def invoice_items_from_merchant(merchant_id)
      invoice_items.joins(:item)
      .where(items: {merchant_id: merchant_id})
    end

    def total_revenue
        invoice_items
        .select('sum(invoice_items.unit_price * invoice_items.quantity)as total')
        .where(invoice_items:{invoice_id: id})
    end

    # total non-discounted revenue for a merchant invoice 

     def total_invoice_revenue(merchant_id)
        items
        .where(items: {merchant_id: merchant_id})
        .sum('invoice_items.unit_price * invoice_items.quantity')
    end

    # revenue for a single invoice item with the max discount applied 
    # also returns the discount id 

    def item_discounted_revenue(item_id)
      items.joins(merchant: :discounts)
      # .where(items: {merchant_id: merchant_id})
      .where(items: {id: item_id})
      .where('discounts.quantity_threshold <= invoice_items.quantity')
      .select('discounts.id as discount_id, (invoice_items.unit_price * invoice_items.quantity * (1 - discounts.percent / 100.0 ) ) as total')
      .group('total, discount_id')
      .order('total')
      .limit(1)
    end 

    def full_name
      customer.first_name + " " + customer.last_name
    end

    def total_price
      invoice_items.sum('unit_price * quantity')
    end

    def total_invoice_revenue_with_discounts
      # binding.pry 
      invoice_items.joins(item: [merchant: :discounts]).distinct 
      .where('discounts.quantity_threshold <= invoice_items.quantity')
      .select('sum(invoice_items.unit_price * invoice_items.quantity * (1 - discounts.percent / 100.0 )) as total')
      
      # .select('items.*, sum(invoice_items.unit_price * invoice_items.quantity * (1 - discounts.percent / 100.0 )) as total')
      # .group('items.id, total')

      # .where('discounts.percent > ? AND discounts.merchant_id = ?, max(discounts.percent), merchants.id')

      # .minimum('invoice_items.unit_price * invoice_items.quantity * (1 - discounts.percent / 100.0 )')
    end 


end
