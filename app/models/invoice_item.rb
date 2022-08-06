class InvoiceItem < ApplicationRecord
  enum status: [:packaged, :pending, :shipped]

  validates_presence_of :quantity
  validates_presence_of :unit_price
  validates_presence_of :status
  validates_presence_of :created_at
  validates_presence_of :updated_at

  belongs_to :item 
  belongs_to :invoice 

  def available_discounts
      item.merchant.discounts.where('discounts.quantity_threshold <= ?', quantity)
  end 
  
  def item_total_no_discounts
    unit_price * quantity
  end

end
