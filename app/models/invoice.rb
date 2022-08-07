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

    def full_name
      customer.first_name + " " + customer.last_name
    end

    def total_price
      invoice_items.sum('unit_price * quantity')
    end 

  # total max discount for items that quality for a discount 

    def discount_total
      x = items.joins(merchant: :discounts)
      .where('discounts.quantity_threshold <= invoice_items.quantity') 
      .select('items.*, max(invoice_items.unit_price * invoice_items.quantity * (discounts.percent / 100.0 )) as discounted')
      .group('items.id')
      .sum(&:discounted)
    end  
end
