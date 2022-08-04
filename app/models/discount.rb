class Discount < ApplicationRecord
    validates_presence_of :percent, :quantity_threshold

    belongs_to :merchant 

end 