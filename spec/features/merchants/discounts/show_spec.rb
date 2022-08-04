require 'rails_helper'

RSpec.describe "merchant discounts index", type: :feature do

    it 'has a discounts for that merchant' do
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)

        discount1 = Discount.create!(percent: 20, quantity_threshold: 5, merchant_id: merchant_1.id)
       
        visit "/merchants/#{merchant_1.id}/discounts/#{discount1.id}"

        expect(page).to have_content("Percent Discount: 20%")
        expect(page).to have_content("Quantity Threshold: 5")
    end

      it 'has a link to edit a discount' do
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)

        discount1 = Discount.create!(percent: 20, quantity_threshold: 5, merchant_id: merchant_1.id)
       
        visit "/merchants/#{merchant_1.id}/discounts/#{discount1.id}"

        click_button("Update Discount: #{discount1.id}")
        expect(current_path).to eq("/merchants/#{merchant_1.id}/discounts/#{discount1.id}/edit")
    end
end