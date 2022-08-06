class Invoice < ApplicationRecord
    enum status: [:completed, "in progress", :cancelled]

    validates_presence_of :status
    validates_presence_of :created_at
    validates_presence_of :updated_at

    has_many :items, through: :invoice_items
    belongs_to :customer
    has_many :invoice_items
    has_many :transactions
    has_many :items, through: :invoice_items
    has_many :merchants, through: :items

    def self.incomplete_invoices_not_shipped
      select('invoices.*').distinct.joins(:invoice_items).where.not(invoice_items: {status: 2}).order('created_at ASC')
    end

    # returns invoice items for a specific merchant (excludes items not from that merchant)

    def invoice_items_from_merchant(merchant_id)
      invoice_items.joins(:item)
      .where(items: {merchant_id: merchant_id})
    end

    def total_revenue
        invoice_items
        .select('sum(invoice_items.unit_price * invoice_items.quantity)as total')
        .where(invoice_items:{invoice_id: id})
    end

    # total non-discounted revenue for a merchant invoice for only that merchants items  

     def total_invoice_revenue(merchant_id)
        items
        .where(items: {merchant_id: merchant_id})
        .sum('invoice_items.unit_price * invoice_items.quantity')
    end

    # revenue for a single invoice item with the max discount applied 
    # also returns the discount id 

    def item_discounted_revenue(item_id)
      items.joins(merchant: :discounts)
      .where(items: {id: item_id})
      .where('discounts.quantity_threshold <= invoice_items.quantity')
      .select('discounts.id as discount_id, (invoice_items.unit_price * invoice_items.quantity * (1 - discounts.percent / 100.0 ) ) as total')
      .group('total, discount_id')
      .order('total')
      .limit(1)
    end 

    # returns the total revenue for an invoice (from all merchants), with discounts applied

    def items_discounted_revenue_total 
      @total = 0
      invoice_items.each do |ii|
        if ii.available_discounts.count != 0
          @total += item_discounted_revenue(ii.item_id)[0].total
        else 
          @total += ii.item_total_no_discounts
        end 
      end
      @total 
    end 

    # returns the total revenue for an invoice (from a single mmerchant), with discounts applied

    def items_discounted_revenue_total_single_merchant(merchant_id)
      @total = 0
      invoice_items_from_merchant(merchant_id).each do |ii|
        if ii.available_discounts.count != 0
          @total += item_discounted_revenue(ii.item_id)[0].total
        else 
          @total += ii.item_total_no_discounts
        end 
      end
      @total 
    end 

    def full_name
      customer.first_name + " " + customer.last_name
    end

    def total_price
      invoice_items.sum('unit_price * quantity')
    end

    def total_invoice_revenue_with_discounts
      # binding.pry 
      # invoice_items.joins(item: [merchant: :discounts])
      # .where('discounts.quantity_threshold <= invoice_items.quantity')
      # .select('DISTINCT ON (invoice_item.item_id)')
      # .where(discounts: {percent: maximum('discounts.percent')})
      # .select('sum(invoice_items.unit_price * invoice_items.quantity * (1 - discounts.percent / 100.0 )) as total')
      # .select('min(invoice_items.unit_price * invoice_items.quantity * (1 - discounts.percent / 100.0 )) as total')
      
      # maximum('discounts.percent', :conditions => ['discounts.quantity_threshold <= invoice_items.quantity'])
      #  Person.minimum(:age, )
      # .select('items.*, sum(invoice_items.unit_price * invoice_items.quantity * (1 - discounts.percent / 100.0 )) as total')
      # .group('items.id, total')

      # .where('discounts.percent > ? AND discounts.merchant_id = ?, max(discounts.percent), merchants.id')
      # .where(items: {merchant_id: merchant_id})
      # .minimum('invoice_items.unit_price * invoice_items.quantity * (1 - discounts.percent / 100.0 )')
    end 


end
