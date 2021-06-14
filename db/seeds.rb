require 'faker'

CITIES = [
  { city: 'Rio', latitude: -22.90684, longitude: -43.17289 },
  { city: 'Honolulu', latitude: 21.3045, longitude: -157.8557 },
  { city: 'Bali', latitude: -8.34054, longitude: 115.091945 },
  { city: 'Rome', latitude: 41.89306, longitude: 12.48278 },
  { city: 'Paris', latitude: 48.85658, longitude: 2.35183 },
  { city: 'Lisbon', latitude: 38.7263, longitude: -9.1484 },
  { city: 'Berlin', latitude: 52.51667, longitude: 13.38333 },
  { city: 'Vancouver', latitude: 49.2609, longitude: -123.1139 },
  { city: 'Sydney', latitude: -33.868, longitude: 151.21 },
  { city: 'Auckland', latitude: -36.85, longitude: 174.78333 },
  { city: 'Chiang Mai', latitude: 18.83722, longitude: 98.97056 },
  { city: 'Singapore', latitude: 1.3516161224392, longitude: 103.808052586332 },
  { city: 'Beirut', latitude: 33.88694, longitude: 35.51306 },
  { city: 'London', latitude: 51.507321899999994, longitude: -0.12764739999999997 },
  { city: 'Oslo', latitude: 59.855058, longitude: 10.814466 }
]

<<<<<<< HEAD
=======

data = {
  rent: { coliving: 1000, hostel: 1500, airbnb: 2000, hotel: 3000 },
  food: { supermarket: 300, restaurant: 800 },
  drink: { never: 0, occasionally: 200, frequently: 800 },
  tobacco: { non_smoker: 0, smoker: 300 },
  utilities: { economical: 400, expensive: 650 },
  recreation: { occasionally: 250, frequently: 600 },
  transportation: { public_transportation: 200, rent_transportation: 600, uber: 400 },
  reference_stuff: { coca_cola_033l: 4, heineken_03l: 6, marlboro_pack: 10, big_mac: 15, nespresso_capsule: 3,
                     jw_red_1l: 80, pellegrino_075l: 20 }
}

>>>>>>> master
puts "Creating users"

Review.destroy_all
Message.destroy_all
User.destroy_all
City.destroy_all
Country.destroy_all
Wishlist.destroy_all
Chatroom.destroy_all


puts 'Creating 20 users'
20.times do |i|
  User.create!(
    email: Faker::Internet.unique.email,
    username: Faker::Name.unique.first_name,
    password: '123123'
  )
end

puts "Creating 15 countries"
15.times do |i|
  Country.create!(
    name: Faker::Address.unique.country,
    language: Faker::Nation.language,
    currency: Faker::Currency.name
  )
end

puts "Creating 15 cities"
CITIES.each do |hash|
  data = {
    rent: { coliving: 1000*rand(1.1..3.0), hostel: 1500*rand(1.1..3.0), airbnb: 2000*rand(1.1..3.0), hotel: 3000*rand(1.1..3.0) },
    food: { supermarket: 100*rand(1.1..3.0), restaurant: 200*rand(1.1..3.0) },
    drink: { occasionally: 100*rand(1.1..3.0), frequently: 200*rand(1.1..3.0) },
    tobacco: { non_user: 0*rand(1.1..3.0), user: 50*rand(1.1..3.0) },
    utilities: { economical: 40*rand(1.1..3.0), expensive: 65*rand(1.1..3.0) },
    recreation: { occasionally: 25*rand(1.1..3.0), frequently: 60*rand(1.1..3.0) },
    transportation: { public_transportation: 30*rand(1.1..3.0), rent_transportation: 50*rand(1.1..3.0) }
  }

  city = City.create!(
    country: Country.all.sample,
    name: hash[:city],
    latitude: hash[:latitude],
    longitude: hash[:longitude],
    temperature: rand(-5..30),
    data: data
    )
end

puts "Creating 50 reviews"
50.times do |i|
  Review.create!(
    content: Faker::Lorem.paragraphs(number: rand(2..4))[0].capitalize,
    user: User.all.sample,
    city: City.all.sample
    )
end

puts "Creating 10 wishlists"
10.times do |i|
  city = City.all.sample
  user = User.all.sample
  while user.wishlists?(city) # Dumb and dangerous, but I'm tired. Keep wishlists number < users or crash
    user = User.all.sample
  end
  Wishlist.create!(
    city: city,
    user: user
    )
end

Chatroom.create(name: "general")

puts 'Finished!'
