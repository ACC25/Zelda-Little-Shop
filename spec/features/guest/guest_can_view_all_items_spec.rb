require 'rails_helper'

RSpec.describe "guest can view index page" do
  it "displays all existing items" do
    category = Category.create(name: "Potions")
    item = Item.create(name: "Milkish", description: "Feeds the body", price: 2, category_id: category.id)
    category2 = Category.create(name: "Food")
    item2 = Item.create!(name: "Milk", description: "Feeds the body", price: 2, category_id: category.id)

    visit items_path

    expect(page).to have_content("All Items")
    expect(page).to have_content(item.name)
    expect(page).to have_content(item2.name)

    first('.btn').click
    
    expect(page).to have_content("You now have 1 #{item.name} in your cart!")
  end
end
