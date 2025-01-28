require(:faker)
# Clear existing records
puts "Clearing existing records..."
Review.destroy_all
Order.destroy_all
Favourite.destroy_all
Inventory.destroy_all
Product.destroy_all
Van.destroy_all
User.destroy_all

# Create Users
puts "Creating Users"
users = []
5.times do |i|
  users << User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    photo: Faker::LoremFlickr.image
  )
end
puts "Users created successfully"
# Create Unique Vans
puts "Creating Vans"
vans = []
users.each do |user|
  vans << Van.create!(
    name: "#{Faker::Food.ingredient} #{Faker::Name.last_name}'s Ice Cream Van",
    location: Faker::Address.full_address,
    user_id: user.id
  )
end
puts "Vans created successfully"
# Create Favourites
puts "Creating Favourites"
favourites = []
5.times do |i|
  favourites << Favourite.create!(
    user_id: users.sample.id,
    van_id: vans.sample.id
  )
end
puts "Favourites created successfully"
# Create Products
puts "Creating Products"
products = []
# Custom array of ice cream descriptions
ice_cream_descriptions = [
  "A classic and creamy treat that brings back childhood memories.",
  "Rich and indulgent, perfect for satisfying your sweet tooth.",
  "A refreshing and fruity delight, bursting with real strawberry flavor.",
  "Minty fresh with chunks of chocolate for a delightful crunch.",
  "Decadent and filled with chunks of chewy cookie dough."
]
ice_cream_flavors = ["Vanilla", "Chocolate", "Strawberry", "Mint Chocolate Chip", "Cookie Dough"]
# Create Products with specific descriptions
ice_cream_flavors.each_with_index do |flavor, index|
  products << Product.create!(
    name: flavor,
    description: ice_cream_descriptions[index],
    photo: Faker::LoremFlickr.image(size: "300x300", search_terms: ['icecream'])
  )
end
puts "Products created successfully"
# Create Inventories
puts "Creating Inventories"
inventories = []
vans.each do |van|
  products.each do |product|
    inventories << Inventory.create!(
      product_id: product.id,
      van_id: van.id,
      quantity_available: 10,
      price: Faker::Commerce.price(range: 1.0..10.0)
    )
  end
end
puts "Inventories created successfully"
# Create Orders
puts "Creating Orders"
orders = []
users.each do |user|
  vans.each do |van|
    orders << Order.create!(
      user_id: user.id,
      van_id: van.id,
      confirmed_status: [true, false].sample,
      paid_status: [true, false].sample
    )
  end
end
puts "Orders created successfully"
# Create Order Products
puts "Creating Order Products"
order_products = []
orders.each do |order|
  products.each do |product|
    order_products << OrderProduct.create!(
      order_id: order.id,
      product_id: product.id,
      quantity_ordered: Faker::Number.between(from: 1, to: 10)
    )
  end
end
puts "Order Products created successfully"
puts "Seeding completed successfully!"
