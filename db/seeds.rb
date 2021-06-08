require 'faker'

CITIES = [
  { city: 'São Paulo', coordinates: '"-23.5507 -46.6334"'},
  { city: 'Rome', coordinates: '41.89306 12.48278'},
  { city: 'Paris', coordinates: '48.85658 2.35183'},
  { city: 'Lisbon', coordinates: '38.7263 -9.1484'},
  { city: 'Berlin', coordinates: '52.51667 13.38333'},
  { city: 'New York', coordinates: '40.7306 -73.9866'},
  { city: 'Vancouver', coordinates: '49.2609 -123.1139'},
  { city: 'Honolulu', coordinates: '21.3045 -157.8557'},
  { city: 'Sydney', coordinates: '-33.868 151.21'},
  { city: 'Auckland', coordinates: '-36.85 174.78333'},
  { city: 'Chiang Mai', coordinates: '18.83722 98.97056'},
  { city: 'Singapore', coordinates: '1.3516161224392 103.808052586332'},
  { city: 'Beirut', coordinates: '33.88694 35.51306'},
  { city: 'London', coordinates: '51.507321899999994 -0.12764739999999997'},
  { city: 'Oslo', coordinates: '59.855058 10.814466'}
]

puts "Creating users"

Review.destroy_all
User.destroy_all
City.destroy_all
Country.destroy_all
Wishlist.destroy_all


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
  city = City.create!(
    country: Country.all.sample,
    name: hash[:city],
    coordinates: hash[:coordinates],
    temperature: rand(-5..30),
    data: {}
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

puts 'Finished!'
