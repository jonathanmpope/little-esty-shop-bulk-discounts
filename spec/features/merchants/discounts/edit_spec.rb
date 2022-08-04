require 'rails_helper'

RSpec.describe "merchant discounts edit page", type: :feature do

    it 'has a discounts for that merchant' do
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)

        discount1 = Discount.create!(percent: 20, quantity_threshold: 5, merchant_id: merchant_1.id)
       
        visit "/merchants/#{merchant_1.id}/discounts/#{discount1.id}/edit"

        within "#merchant_discount_edit" do 
            expect(page).to have_field('discount[percent]', with: "20")
            expect(page).to have_field('discount[quantity_threshold]', with: "5")
        end 

        fill_in("Percent", with: "30")
        click_on("Update Discount")

        expect(current_path).to eq("/merchants/#{merchant_1.id}/discounts/#{discount1.id}")

        expect(page).to have_content("Percent Discount: 30%")
        expect(page).to have_content("Quantity Threshold: 5")
    end
end