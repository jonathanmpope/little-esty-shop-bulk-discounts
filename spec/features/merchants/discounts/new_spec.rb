require 'rails_helper'

RSpec.describe "merchant new discount page", type: :feature do
    it 'has a create a new discount page' do 
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)

        discount1 = Discount.create!(percent: 20, quantity_threshold: 5, merchant_id: merchant_1.id)
        discount2 = Discount.create!(percent: 10, quantity_threshold: 3, merchant_id: merchant_1.id)

        visit "/merchants/#{merchant_1.id}/discounts/new" 

        fill_in("Percent", with: "30")
        click_on("Create Discount")

        expect(current_path).to eq("/merchants/#{merchant_1.id}/discounts/new")
        expect(page).to have_content("Error: Please fill out all required fields!")
       
        fill_in("Percent", with: "130")
        fill_in("quantity_threshold", with: "20")
        click_on("Create Discount")

        expect(current_path).to eq("/merchants/#{merchant_1.id}/discounts/new")
        expect(page).to have_content("Error: Please fill out all required fields!")

        fill_in("Percent", with: "30")
        fill_in("quantity_threshold", with: "20")
        click_on("Create Discount")

        expect(current_path).to eq("/merchants/#{merchant_1.id}/discounts")

        within('#discounts') do
            expect(page.all(".discount")[0]).to have_content("Percent Discount: 20%")
            expect(page.all(".discount")[0]).to have_content("Quantity Threshold: 5")
            expect(page.all(".discount")[0]).to have_content("View Discount #{discount1.id} Info")
            expect(page.all(".discount")[1]).to have_content("Percent Discount: 10%")
            expect(page.all(".discount")[1]).to have_content("Quantity Threshold: 3")
            expect(page.all(".discount")[1]).to have_content("View Discount #{discount2.id} Info")
            expect(page.all(".discount")[2]).to have_content("Percent Discount: 30%")
            expect(page.all(".discount")[2]).to have_content("Quantity Threshold: 20")
        end
    end 

end 