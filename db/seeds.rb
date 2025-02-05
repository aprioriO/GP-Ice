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


55.times do |i|
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
  "123 Elm Street, Hackney, London, E8 3NN, United Kingdom",
  "45 Maple Avenue, Camden, London, NW1 8AB, United Kingdom",
  "789 Pine Road, Islington, London, N1 2JH, United Kingdom",
  "56 Cherry Lane, Southwark, London, SE1 3RT, United Kingdom",
  "32 Birch Grove, Lewisham, London, SE13 7AX, United Kingdom",
  "99 Oakwood Drive, Hammersmith, London, W6 9LP, United Kingdom",
  "74 Cedar Crescent, Kensington, London, W8 5RD, United Kingdom",
  "198 Walnut Street, Tower Hamlets, London, E1 1DZ, United Kingdom",
  "6 Willow Way, Lambeth, London, SW2 3TL, United Kingdom",
  "25 Sycamore Drive, Wandsworth, London, SW18 4LJ, United Kingdom",
  "82 Poplar Street, Greenwich, London, SE10 8NZ, United Kingdom",
  "41 Fir Avenue, Bromley, London, BR1 2QY, United Kingdom",
  "10 Hawthorn Drive, Croydon, London, CR0 4HJ, United Kingdom",
  "67 Spruce Road, Redbridge, London, IG1 3JU, United Kingdom",
  "90 Alder Street, Enfield, London, EN1 1GF, United Kingdom",
  "53 Ash Drive, Barnet, London, EN5 4BX, United Kingdom",
  "21 Beech Street, Hounslow, London, TW3 1XP, United Kingdom",
  "88 Elmwood Road, Richmond, London, TW10 6JF, United Kingdom",
  "47 Linden Avenue, Ealing, London, W5 5HJ, United Kingdom",
  "35 Chestnut Lane, Brent, London, NW10 2TT, United Kingdom",
  "58 Redwood Drive, Harrow, London, HA2 0JP, United Kingdom",
  "106 Sequoia Street, Hillingdon, London, UB8 1QP, United Kingdom",
  "77 Pinehurst Avenue, Haringey, London, N8 7QT, United Kingdom",
  "19 Magnolia Drive, Merton, London, SW19 5LS, United Kingdom",
  "66 Juniper Road, Sutton, London, SM1 3PN, United Kingdom",
  "93 Cypress Lane, Bexley, London, DA5 1JG, United Kingdom",
  "12 Holly Way, Havering, London, RM1 4HL, United Kingdom",
  "84 Hazel Street, Kingston, London, KT1 1XN, United Kingdom",
  "39 Palm Drive, Barking, London, IG11 9HJ, United Kingdom",
  "105 Pinewood Street, Dagenham, London, RM9 5RJ, United Kingdom",
  "28 Oakley Road, Waltham Forest, London, E17 4DL, United Kingdom",
  "71 Aspen Avenue, Newham, London, E13 9LX, United Kingdom",
  "60 Palm Grove, Westminster, London, SW1P 3LT, United Kingdom",
  "23 Elmwood Lane, Tower Hamlets, London, E2 9FN, United Kingdom",
  "49 Birchwood Road, Hackney, London, E5 8PL, United Kingdom",
  "110 Redwood Way, Camden, London, NW3 5SA, United Kingdom",
  "16 Spruce Lane, Islington, London, N7 9UB, United Kingdom",
  "81 Chestnut Drive, Southwark, London, SE1 2JL, United Kingdom",
  "14 Beechwood Avenue, Lewisham, London, SE13 6GH, United Kingdom",
  "89 Maplewood Road, Hammersmith, London, W6 8GH, United Kingdom",
  "27 Oakdale Street, Kensington, London, W14 0QF, United Kingdom",
  "97 Hawthorn Street, Tower Hamlets, London, E1 2HR, United Kingdom",
  "54 Elmhurst Lane, Lambeth, London, SW9 0TJ, United Kingdom",
  "40 Maple Street, Wandsworth, London, SW18 3DT, United Kingdom",
  "33 Birchfield Drive, Greenwich, London, SE10 9GN, United Kingdom",
  "85 Willow Street, Bromley, London, BR2 0RE, United Kingdom",
  "7 Pinecrest Avenue, Croydon, London, CR0 2HT, United Kingdom",
  "68 Cedar Road, Redbridge, London, IG4 5PL, United Kingdom",
  "52 Poplar Lane, Enfield, London, EN2 0SY, United Kingdom",
  "34 Fir Drive, Barnet, London, EN4 8JH, United Kingdom",
]
users.each_with_index do |user, index|
  random_number = rand(0..10)
  van_name = "#{Faker::Name.first_name} #{random_number}'s Ice Cream Van"
  vans << Van.create!(
    name: van_name,
    location: addresses[index % addresses.length], # Assign addresses in a round-robin fashion
    user_id: user.id
  )
end
puts "Vans created successfully"
# Create Favourites
puts "Creating Favourites"
favourites = []
5.times do
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

asset_image_paths = [
  "01_vanilla.png",
  "02_chocolate.png",
  "03_strawberry.png",
  "04_chocolate_chip.png",
  "05_cookie_dough.png"
]

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
      price: Faker::Commerce.price(range: 1..10)
    )
  end
end
puts "Inventories created successfully"
# Create Orders
puts "Creating Orders"
orders = []
sampled_users = users.sample(5)
sampled_vans = vans.sample(5)

sampled_users.each do |user|
  sampled_vans.each do |van|
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
