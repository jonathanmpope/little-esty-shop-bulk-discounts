require 'rails_helper'

RSpec.describe "merchant discounts index", type: :feature do

    it 'has a discounts for that merchant' do
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
        merchant_2 = Merchant.create!(name: "Durp", created_at: Time.now, updated_at: Time.now)

        discount1 = Discount.create!(percent: 20, quantity_threshold: 5, merchant_id: merchant_1.id)
        discount2 = Discount.create!(percent: 10, quantity_threshold: 3, merchant_id: merchant_1.id)
        discount3 = Discount.create!(percent: 15, quantity_threshold: 10, merchant_id: merchant_2.id)

        visit "/merchants/#{merchant_1.id}/discounts"

        expect(page).to_not have_content("Percent Discount: 15%")
        expect(page).to_not have_content("Quantity Threshold: 10")

         within('#discounts') do
            expect(page.all(".discount")[0]).to have_content("Percent Discount: 20%")
            expect(page.all(".discount")[0]).to have_content("Quantity Threshold: 5")
            expect(page.all(".discount")[0]).to have_content("View Discount #{discount1.id} Info")
            expect(page.all(".discount")[1]).to have_content("Percent Discount: 10%")
            expect(page.all(".discount")[1]).to have_content("Quantity Threshold: 3")
            expect(page.all(".discount")[1]).to have_content("View Discount #{discount2.id} Info")
        end

        click_on("View Discount #{discount1.id} Info")
        expect(current_path).to eq("/merchants/#{merchant_1.id}/discounts/#{discount1.id}")
    end

    it 'has a link to create a new discount' do
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
    
        discount1 = Discount.create!(percent: 20, quantity_threshold: 5, merchant_id: merchant_1.id)
        discount2 = Discount.create!(percent: 10, quantity_threshold: 3, merchant_id: merchant_1.id)

        visit "/merchants/#{merchant_1.id}/discounts"

        expect(page).to have_content("Create a New Discount")

        click_on("Create a New Discount")
        expect(current_path).to eq("/merchants/#{merchant_1.id}/discounts/new")
    end
end 