require 'rails_helper'

RSpec.describe 'invoices show page' do
  it 'displays a list of all the invoices and their attributes' do
    merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
    item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
    invoice_1 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
    invoice_2 = customer_1.invoices.create!(status: 2, created_at: Time.now, updated_at: Time.now)
    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
    invoice_item_2 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_2.id, quantity: 1, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)

    # visit_merchant_invoice_path(merchant_1, invoice_1)
    visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

    expect(page).to have_content(invoice_1.id)
    expect(page).to have_content(invoice_1.status)
    expect(page).to have_content(invoice_1.created_at.strftime("%-m/%d/%y"))
    expect(page).to have_content(invoice_1.full_name)
    expect(page).to_not have_content(invoice_2.id)
    expect(page).to_not have_content(invoice_2.status)

  end

  it 'shows all of my items on the invoice and their attributes' do
    merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
    item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    item_4 = Item.create!(name: "Socks", description: "Everyone loves socks", unit_price: 6000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
    invoice_1 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
    invoice_2 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
    invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_2.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
    invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_3.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
    invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_2.id, quantity: 1, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)

    visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"
      expect(page).to have_content("Item Name: #{item_1.name}")
      expect(page).to have_content("Quantity Ordered: #{invoice_item_1.quantity}")
      expect(page).to have_content("Item Price: $30.00")
      expect(page).to have_content("Invoice Item Status: #{invoice_item_1.status}")
      expect(page).to have_content("Item Name: #{item_2.name}")
      expect(page).to have_content("Quantity Ordered: #{invoice_item_2.quantity}")
      expect(page).to have_content("Item Price: $40.00")
      expect(page).to have_content("Invoice Item Status: #{invoice_item_2.status}")
      expect(page).to have_content("Item Name: #{item_3.name}")
      expect(page).to have_content("Quantity Ordered: #{invoice_item_3.quantity}")
      expect(page).to have_content("Item Price: $50.00")
      expect(page).to have_content("Invoice Item Status: #{invoice_item_3.status}")
      expect(page).to_not have_content("#{item_4.name}")
    end

    it 'shows the total revenue of all of the items on the invoice' do
      merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
      item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_4 = Item.create!(name: "Socks", description: "Everyone loves socks", unit_price: 6000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
      invoice_1 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
      invoice_2 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_2.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
      invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_3.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
      invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_2.id, quantity: 1, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)

      visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

      expect(page).to have_content("Total Invoice Revenue: $120.00")
    end

    it 'can update the invoice item status' do
      merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
      item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_4 = Item.create!(name: "Socks", description: "Everyone loves socks", unit_price: 6000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
      invoice_1 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
      invoice_2 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)

      visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

       expect(invoice_item_1.status).to eq("packaged")
       select("pending", from: "status")
       click_button "Update Item Status"
       expect(current_path).to eq(merchant_invoice_path(merchant_1, invoice_1))
       expect(page).to have_content("pending")
     end

     it 'has shows the total for an invoice - both total and discounted - example 1' do
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)

        item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        
        customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
        
        invoice_1 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
        
        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 5, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 5, unit_price: item_2.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)

        discount1 = Discount.create!(percent: 20, quantity_threshold: 10, merchant_id: merchant_1.id)

        visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

        expect(page).to have_content("Total Merchant Revenue Before Discounts: $350.00")
        expect(page).to have_content("Total Merchant Revenue After Discounts: $350.00")
     end 

      it 'has shows the total for an invoice - both total and discounted - example 2' do
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)

        item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        
        customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
        
        invoice_1 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
        
        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 10, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 5, unit_price: item_2.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)

        discount1 = Discount.create!(percent: 20, quantity_threshold: 10, merchant_id: merchant_1.id)

        visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

        expect(page).to have_content("Total Merchant Revenue Before Discounts: $500.00")
        expect(page).to have_content("Total Merchant Revenue After Discounts: $440.00")
        
     end 

      it 'has shows the total for an invoice - both total and discounted - example 3' do
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)

        item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        
        customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
        
        invoice_1 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
        
        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 12, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 15, unit_price: item_2.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)

        discount1 = Discount.create!(percent: 20, quantity_threshold: 10, merchant_id: merchant_1.id)
        discount1 = Discount.create!(percent: 30, quantity_threshold: 15, merchant_id: merchant_1.id)

        visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

        expect(page).to have_content("Total Merchant Revenue Before Discounts: $960.00")
        expect(page).to have_content("Total Merchant Revenue After Discounts: $708.00")
     end 

     it 'has shows the total for an invoice - both total and discounted - example 4' do
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)

        item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        
        customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
        
        invoice_1 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
        
        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 12, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 15, unit_price: item_2.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)

        discount1 = Discount.create!(percent: 20, quantity_threshold: 10, merchant_id: merchant_1.id)
        discount1 = Discount.create!(percent: 15, quantity_threshold: 15, merchant_id: merchant_1.id)

        visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

        expect(page).to have_content("Total Merchant Revenue Before Discounts: $960.00")
        expect(page).to have_content("Total Merchant Revenue After Discounts: $768.00")
     end 

      it 'can deal with discounts that apply to items not belonging to the merchant' do
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
        merchant_2 = Merchant.create!(name: "Bates", created_at: Time.now, updated_at: Time.now)

        item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_3 = Item.create!(name: "Landals", description: "Sandals for the Land", unit_price: 4000, merchant_id: merchant_2.id, created_at: Time.now, updated_at: Time.now)
        
        customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)

        invoice_1 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
        
        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 12, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 15, unit_price: item_2.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 15, unit_price: item_3.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)

        discount1 = Discount.create!(percent: 20, quantity_threshold: 10, merchant_id: merchant_1.id)
        discount2 = Discount.create!(percent: 15, quantity_threshold: 15, merchant_id: merchant_1.id)
        discount3 = Discount.create!(percent: 15, quantity_threshold: 15, merchant_id: merchant_2.id)

        visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

        expect(page).to have_content("Total Merchant Revenue Before Discounts: $960.00")
        expect(page).to have_content("Total Merchant Revenue After Discounts: $768.00")
     end 

     it 'has shows the total for an invoice - both total and discounted' do
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
        merchant_2 = Merchant.create!(name: "Barney", created_at: Time.now, updated_at: Time.now)

        item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_4 = Item.create!(name: "Dino", description: "Stuffed animal", unit_price: 5000, merchant_id: merchant_2.id, created_at: Time.now, updated_at: Time.now)
        
        customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
        
        invoice_1 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
        
        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 5, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 10, unit_price: item_2.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 3, unit_price: item_3.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_1.id, quantity: 10, unit_price: item_4.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)

        discount1 = Discount.create!(percent: 10, quantity_threshold: 5, merchant_id: merchant_1.id)
        discount2 = Discount.create!(percent: 20, quantity_threshold: 10, merchant_id: merchant_1.id)

        visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

        expect(page).to have_content("Total Merchant Revenue Before Discounts: $700.00")
        expect(page).to have_content("Total Merchant Revenue After Discounts: $605.00")
     end 

     it 'has links to discounts (if applied) to an invoice item' do
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
        merchant_2 = Merchant.create!(name: "Barney", created_at: Time.now, updated_at: Time.now)

        item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_4 = Item.create!(name: "Dino", description: "Stuffed animal", unit_price: 5000, merchant_id: merchant_2.id, created_at: Time.now, updated_at: Time.now)
        
        customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
        
        invoice_1 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
        
        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 5, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 10, unit_price: item_2.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 3, unit_price: item_3.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
        invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_1.id, quantity: 10, unit_price: item_4.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)

        discount1 = Discount.create!(percent: 10, quantity_threshold: 5, merchant_id: merchant_1.id)
        discount2 = Discount.create!(percent: 20, quantity_threshold: 10, merchant_id: merchant_1.id)

        visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

        within ("#merchant_invoice_items") do 
            expect(page.all('.merchant_invoice_item')[0]).to have_content("Discount Page")
            expect(page.all('.merchant_invoice_item')[1]).to have_content("Discount Page")
            expect(page.all('.merchant_invoice_item')[2]).to_not have_content("Discount Page")
        end

        within (page.all(".merchant_invoice_item")[0]) do
            expect(page).to have_link("Discount Page")
            click_link("Discount Page")
            expect(current_path).to eq("/merchants/#{merchant_1.id}/discounts/#{discount1.id}")
        end
     end 
end
