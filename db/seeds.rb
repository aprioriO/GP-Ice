# require 'cloudinary'
# require "open-uri"
require 'faker'
# Clear existing records
Review.destroy_all
Order.destroy_all
Favourite.destroy_all
Inventory.destroy_all
Product.destroy_all
Van.destroy_all
User.destroy_all
# Create Users
users = []

user_images_paths = [
  "icecream_van_1.png",
  "icecream_van_2.png",
  "icecream_van_3.png",
  "icecream_van_4.png",
  "icecream_van_5.png"
]
puts "Creating Users"


5.times do |i|
  users << User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    photo: user_images_paths[i]
  )
end
puts "Users created successfully"
# Create Unique Vans
puts "Creating Vans"
vans = []
addresses = [
  "123 High Street, Palmers Green, London, N13 4XZ, United Kingdom",
  "456 Green Lanes, Winchmore Hill, London, N14 4YZ, United Kingdom",
  "789 Woodside Avenue, Southgate, London, EN4 5AB, United Kingdom",
  "321 Church Street, Arnos Grove, London, N22 4CD, United Kingdom",
  "654 Oakwood Park, New Southgate, London, N17 9EF, United Kingdom",
]
users.each_with_index do |user, index|
  vans << Van.create!(
    name: "#{Faker::Food.ingredient} #{Faker::Name.last_name}'s Ice Cream Van",
    location: addresses[index % addresses.length], # Assign addresses in a round-robin fashion
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
  "Fresh with chunks of chocolate for a delightful crunch.",
  "Decadent and filled with chunks of chewy cookie dough."
]
<<<<<<< HEAD
=======

>>>>>>> 893ccc15810497e82fbee74c8aa43ad69bd357a5
asset_image_paths = [
  "01_vanilla.png",
  "02_chocolate.png",
  "03_strawberry.png",
  "04_chocolate_chip.png",
  "05_cookie_dough.png"
]
<<<<<<< HEAD
=======

asset_image_paths = [
  "01_vanilla.png",
  "02_chocolate.png",
  "03_strawberry.png",
  "04_chocolate_chip.png",
  "05_cookie_dough.png"
]


>>>>>>> 893ccc15810497e82fbee74c8aa43ad69bd357a5
ice_cream_flavors = ["Vanilla", "Chocolate", "Strawberry", "Mint Chocolate Chip", "Cookie Dough"]
# Create Products with specific descriptions
ice_cream_flavors.each_with_index do |flavor, index|
  products << Product.create!(
    name: flavor,
    description: ice_cream_descriptions[index],
    photo: asset_image_paths[index]
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
