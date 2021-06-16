require 'faker'

CITIES = [
  { city: 'Rio', latitude: -22.90684, longitude: -43.17289, overall_score: 9.0, temperature: 31, city_type: 'cheap',
    country: 'Brazil', language: 'Portuguese', currency: 'BRL'},
  { city: 'Honolulu', latitude: 21.3045, longitude: -157.8557, overall_score: 8.5, temperature: 30,
    city_type: 'expensive', country: 'USA', language: 'English', currency: 'USD' },
  { city: 'Bali', latitude: -8.34054, longitude: 115.091945, overall_score: 9.9, temperature: 30, city_type: 'cheap',
    country: 'Indonesia', language: 'Indonesian', currency: 'IDR' },
  { city: 'Rome', latitude: 41.89306, longitude: 12.48278, overall_score: 7.6, temperature: 28, city_type: 'normal',
    country: 'Italy', language: 'Italian', currency: 'EUR' },
  { city: 'Paris', latitude: 48.85658, longitude: 2.35183, overall_score: 6.5, temperature: 25, city_type: 'expensive',
    country: 'France', language: 'French', currency: 'EUR' },
  { city: 'Lisbon', latitude: 38.7263, longitude: -9.1484, overall_score: 8.3, temperature: 25, city_type: 'normal',
    country: 'Portugal', language: 'Portuguese', currency: 'EUR' },
  { city: 'Berlin', latitude: 52.51667, longitude: 13.38333, overall_score: 8.3, temperature: 22, city_type: 'cheap',
    country: 'Germany', language: 'German', currency: 'EUR' },
  { city: 'Vancouver', latitude: 49.2609, longitude: -123.1139, overall_score: 7.3, temperature: 20, city_type: 'normal',
    country: 'Canada', language: 'English/French', currency: 'CAD' },
  { city: 'Sydney', latitude: -33.868, longitude: 151.21, overall_score: 6.3, temperature: 28, city_type: 'expensive',
    country: 'Australia', language: 'English', currency: 'AUD' },
  { city: 'Auckland', latitude: -36.85, longitude: 174.78333, overall_score: 6.3, temperature: 28, city_type: 'expensive',
    country: 'New Zealand', language: 'English', currency: 'NZD' },
  { city: 'Chiang Mai', latitude: 18.83722, longitude: 98.97056, overall_score: 9.7, temperature: 32, city_type: 'cheap',
    country: 'Thailand', language: 'Thai', currency: 'THB' },
  { city: 'Singapore', latitude: 1.3516161224392, longitude: 103.808052586332, overall_score: 6.2, temperature: 33,
    city_type: 'expensive', country: 'Brazil', language: 'Portuguese', currency: 'BRL' },
  { city: 'Beirut', latitude: 33.88694, longitude: 35.51306, overall_score: 8.4, temperature: 27, city_type: 'normal',
    country: 'Lebanon', language: 'Lebanese Arabic', currency: 'LBP' },
  { city: 'London', latitude: 51.507321899999994, longitude: -0.12764739999999997, overall_score: 7.4, temperature: 21,
    city_type: 'expensive', country: 'UK', language: 'English', currency: 'GBP' },
  { city: 'Oslo', latitude: 59.855058, longitude: 10.814466, overall_score: 6.2, temperature: 15, city_type: 'expensive',
    country: 'Norway', language: 'Norwegian', currency: 'NOK' },
  { city: 'Lagos', latitude: 6.455027, longitude: 3.384082, overall_score: 5.2, temperature: 25, city_type: 'cheap',
    country: 'Nigeria', language: 'English', currency: 'NGN' },
  { city: 'Cape Town', latitude: -33.925278, longitude: 18.423889, overall_score: 7.2, temperature: 15, city_type: 'normal',
    country: 'South Africa', language: 'English', currency: 'ZAR' },
  { city: 'Gaborone', latitude: -24.658333, longitude: 25.908333, overall_score: 6.2, temperature: 25, city_type: 'cheap',
    country: 'Botswana', language: 'English', currency: 'BWP' },
  { city: 'Montevideo', latitude: -34.883611, longitude: -56.181944, overall_score: 8.2, temperature: 15, city_type: 'expensive',
    country: 'Uruguay', language: 'Spanish', currency: 'UYU' }
]

puts "Seeding DB"

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

puts "Creating cities with respective countries"
CITIES.each do |hash|
  data = {
    rent: { coliving: 400*rand(1.1..2.0), hostel: 600*rand(1.1..2.0), airbnb: 800*rand(1.1..2.0), hotel: 1000*rand(1.1..2.0) },
    food: { supermarket: 200*rand(1.1..3.0), restaurant: 400*rand(1.1..3.0) },
    drink: { occasionally: 200*rand(1.1..3.0), frequently: 400*rand(1.1..3.0) },
    tobacco: { non_user: 0*rand(1.1..3.0), user: 150*rand(1.1..3.0) },
    utilities: { economical: 100*rand(1.1..3.0), expensive: 200*rand(1.1..3.0) },
    recreation: { occasionally: 60*rand(1.1..3.0), frequently: 120*rand(1.1..3.0) },
    transportation: { public_transportation: 60*rand(1.1..3.0), rent_transportation: 100*rand(1.1..3.0) }
  }

  country = Country.create!(name: hash[:country], language: hash[:language], currency: hash[:currency])

  city = City.create!(
    country: country,
    name: hash[:city],
    latitude: hash[:latitude],
    longitude: hash[:longitude],
    temperature: hash[:temperature],
    overall_score: hash[:overall_score],
    city_type: hash[:city_type],
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
