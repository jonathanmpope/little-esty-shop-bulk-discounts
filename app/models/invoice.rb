class Invoice < ApplicationRecord
    enum status: [:completed, "in progress", :cancelled]

    validates_presence_of :status
    validates_presence_of :created_at
    validates_presence_of :updated_at
    has_many :invoice_items, dependent: :destroy
    has_many :transactions, dependent: :destroy
    has_many :items, through: :invoice_items

    belongs_to :customer
    has_many :invoice_items
    has_many :transactions
    has_many :items, through: :invoice_items


    def self.incomplete_invoices_not_shipped
        select('invoices.*').distinct.joins(:invoice_items).where.not(invoice_items: {status: 2}).order('created_at ASC')
    end


    def total_revenue
        invoice_items
        .select('sum(invoice_items.unit_price * invoice_items.quantity)as total')
        .where(invoice_items:{invoice_id: id})
    end

     def total_invoice_revenue(merchant_id)
        items.select('sum(invoice_items.unit_price * invoice_items.quantity)as total')
        .where(items: {merchant_id: merchant_id})
    end

    def full_name
      customer.first_name + " " + customer.last_name
    end

    def total_price
      invoice_items.sum('unit_price * quantity')
    end

end
