class Transaction < ApplicationRecord
    validates_presence_of :credit_card_number
    validates_presence_of :result
    validates_presence_of :created_at
    validates_presence_of :updated_at

    belongs_to :invoice 

end 