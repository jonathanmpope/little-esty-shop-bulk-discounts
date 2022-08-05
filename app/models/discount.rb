class Discount < ApplicationRecord
    validates :percent, inclusion: { in: 0..100  }
    validates_presence_of :quantity_threshold

    belongs_to :merchant

end 