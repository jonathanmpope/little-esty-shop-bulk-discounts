class Discount < ApplicationRecord
    validates :percent, inclusion: { in: 1..100  }
    validates_presence_of :quantity_threshold

    belongs_to :merchant
end 