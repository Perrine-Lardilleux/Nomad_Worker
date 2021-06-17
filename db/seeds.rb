require 'faker'

CITIES = [
  { city: 'Rio de Janeiro', latitude: -22.90684, longitude: -43.17289, overall_score: 9.0, temperature: 31, city_type: 'cheap',
    country: 'Brazil', language: 'Portuguese', currency: 'BRL', weather: {
    temp: [26.3, 26.6, 26.0, 24.4, 22.8, 21.8, 21.3, 21.8, 22.2, 22.9, 24.0, 25.3, 23.8,],
    rain: [137.1, 130.4, 135.8, 94.9, 69.8, 42.7, 41.9, 44.5, 53.6, 86.5, 97.8, 134.2, 1069.4],
    sunshine: [211.9, 201.3, 206.4, 181.0, 186.3, 175.1, 188.6, 184.8, 146.2, 152.1, 168.5, 179.6, 2181.8]
  }},
  { city: 'Honolulu', latitude: 21.3045, longitude: -157.8557, overall_score: 8.5, temperature: 30,
    city_type: 'expensive', country: 'USA', language: 'English', currency: 'USD', weather: {
    temp: [22.9, 22.8, 23.6, 24.5, 25.4, 26.8, 27.3, 27.7, 27.5, 26.7, 25.3, 23.8, 25.4],
    rain: [59, 51, 51, 16, 16, 6.6, 13, 14, 18, 47, 61, 82, 434],
    sunshine: [213.5, 212.7, 259.2, 251.8, 280.6, 286.1, 306.2, 303.1, 278.8, 244.0, 200.4, 199.5, 3035.9]
  }},
  { city: 'Bali', latitude: -8.34054, longitude: 115.091945, overall_score: 9.9, temperature: 30, city_type: 'cheap',
    country: 'Indonesia', language: 'Indonesian', currency: 'IDR', weather: {
    temp: [28.6, 28.8, 28.8, 29.6, 28.6, 27.4, 26.7, 26.1, 27.1, 28.6, 28.1, 28.2, 28.1],
    rain: [345, 274, 234, 88, 93, 53, 55, 25, 47, 63, 179, 276, 1732],
    sunshine: [173.1, 174.0, 210.7, 224.7, 242.9, 228.1, 246.8, 261.7, 251.3, 252.5, 224.4, 176.4, 2666.6]
  }},
  { city: 'Rome', latitude: 41.89306, longitude: 12.48278, overall_score: 7.6, temperature: 28, city_type: 'expensive',
    country: 'Italy', language: 'Italian', currency: 'EUR', weather: {
    temp: [7.4, 8.4, 10.4, 12.9, 17.3, 21.2, 24.2, 24.5, 20.9, 16.4, 11.2, 8.2, 15.3],
    rain: [69.5, 75.8, 59.0, 76.2, 49.1, 40.7, 21.0, 34.1, 71.8, 107.0, 109.9, 84.4, 798.5],
    sunshine: [120.9, 132.8, 167.4, 201.0, 263.5, 285.0, 331.7, 297.6, 237.0, 195.3, 129.0, 111.6, 2473]
  }},
  { city: 'Paris', latitude: 48.85658, longitude: 2.35183, overall_score: 6.5, temperature: 25, city_type: 'expensive',
    country: 'France', language: 'French', currency: 'EUR', weather: {
    temp: [4.9, 5.6, 8.8, 11.5, 15.2, 18.3, 20.5, 20.3, 16.9, 13.0, 8.3, 5.5, 12.4],
    rain: [51.0, 41.2, 47.6, 51.8, 63.2, 49.6, 62.3, 52.7, 47.6, 61.5, 51.1, 57.8, 637.4],
    sunshine: [62.5, 79.2, 128.9, 166.0, 193.8, 202.1, 212.2, 212.1, 167.9, 117.8, 67.7, 51.4, 1661.6]
  }},
  { city: 'Lisbon', latitude: 38.7263, longitude: -9.1484, overall_score: 8.3, temperature: 25, city_type: 'normal',
    country: 'Portugal', language: 'Portuguese', currency: 'EUR', weather: {
    temp: [11.6, 12.7, 14.9, 15.9, 18.0, 21.2, 23.1, 23.5, 22.1, 18.8, 15.0, 12.4, 17.4],
    rain: [99.9, 84.9, 53.2, 68.1, 53.6, 15.9, 4.2, 6.2, 32.9, 100.8, 127.6, 126.7, 774],
    sunshine: [142.6, 156.6, 207.7, 234.0, 291.4, 303.0, 353.4, 344.1, 261.0, 213.9, 156.0, 142.6, 2806.3]
  }},
  { city: 'Berlin', latitude: 52.51667, longitude: 13.38333, overall_score: 8.3, temperature: 22, city_type: 'expensive',
    country: 'Germany', language: 'German', currency: 'EUR', weather: {
    temp: [0.1, 0.9, 4.3, 9.0, 14.0, 16.8, 19.1, 18.5, 14.2, 9.4, 4.4, 1.0, 9.3],
    rain: [37.2, 30.1, 39.3, 33.7, 52.6, 60.2, 52.5, 53.0, 39.5, 32.2, 37.8, 46.1, 515.2],
    sunshine: [57.6, 71.5, 119.4, 191.2, 229.6, 230.0, 232.4, 217.3, 162.3, 114.7, 54.9, 46.9, 1727.6]
  }},
  { city: 'Vancouver', latitude: 49.2609, longitude: -123.1139, overall_score: 7.3, temperature: 20, city_type: 'expensive',
    country: 'Canada', language: 'English/French', currency: 'CAD', weather: {
    temp: [4.1, 4.9, 6.9, 9.4, 12.8, 15.7, 18.0, 18.0, 14.9, 10.3, 6.3, 3.6, 10.4],
    rain: [168.4, 104.6, 113.9, 88.5, 65.0, 53.8, 35.6, 36.7, 50.9, 120.8, 188.9, 161.9, 1189],
    sunshine: [60.2, 91.0, 134.8, 185.0, 222.5, 226.9, 289.8, 277.1, 212.8, 120.7, 60.4, 56.5, 1937.5]
  }},
  { city: 'Sydney', latitude: -33.868, longitude: 151.21, overall_score: 6.3, temperature: 28, city_type: 'expensive',
    country: 'Australia', language: 'English', currency: 'AUD', weather: {
    temp: [24.8, 23.9, 22.1, 18.8, 15.2, 12.5, 11.6, 13.1, 16.4, 19.0, 21.2, 23.1, 18.4],
    rain: [91.1, 131.5, 117.5, 114.1, 100.8, 142.0, 80.3, 75.1, 63.4, 67.7, 90.6, 73.0, 1147.1],
    sunshine: [232.5, 205.9, 210.8, 213.0, 204.6, 171.0, 207.7, 248.0, 243.0, 244.9, 222.0, 235.6, 2639]
  }},
  { city: 'Auckland', latitude: -36.85, longitude: 174.78333, overall_score: 6.3, temperature: 28, city_type: 'expensive',
    country: 'New Zealand', language: 'English', currency: 'NZD', weather: {
    temp: [19.1, 19.7, 18.4, 16.1, 14.0, 11.8, 10.9, 11.3, 12.7, 14.2, 15.7, 17.8, 15.2],
    rain: [73.3, 66.1, 87.3, 99.4, 112.6, 126.4, 145.1, 118.4, 105.1, 100.2, 85.8, 92.8, 1210.7],
    sunshine: [228.8, 194.9, 189.2, 157.3, 139.8, 110.3, 128.1, 142.9, 148.6, 178.1, 188.1, 197.2, 2003.1]
  }},
  { city: 'Chiang Mai', latitude: 18.83722, longitude: 98.97056, overall_score: 9.7, temperature: 32, city_type: 'cheap',
    country: 'Thailand', language: 'Thai', currency: 'THB', weather: {
    temp: [21.5, 23.9, 27.1, 29.3, 28.2, 27.6, 27.2, 26.8, 26.7, 26.1, 24.0, 21.4, 25.8],
    rain: [4.2, 8.9, 17.8, 57.3, 162.0, 124.5, 140.2, 216.9, 211.4, 117.6, 53.9, 15.9, 1130.6],
    sunshine: [272.8, 257.1, 294.5, 279.0, 198.4, 156.0, 120.9, 117.8, 144.0, 201.5, 216.0, 254.2, 2512.2]
  }},
  { city: 'Singapore', latitude: 1.3516161224392, longitude: 103.808052586332, overall_score: 6.2, temperature: 33,
    city_type: 'expensive', country: 'Singapore', language: 'English', currency: 'SGD', weather: {
    temp: [26.5, 27.1, 27.5, 28.0, 28.3, 28.3, 27.9, 27.9, 27.6, 27.6, 27.0, 26.4, 27.5],
    rain: [234.6, 112.8, 170.3, 154.8, 171.2, 130.7, 154.4, 148.9, 156.5, 154.6, 258.5, 318.6, 2165.9],
    sunshine: [172.4, 183.2, 192.7, 173.6, 179.8, 177.7, 187.9, 180.6, 156.2, 155.2, 129.6, 133.5, 2022.4]
  }},
  { city: 'Beirut', latitude: 33.88694, longitude: 35.51306, overall_score: 8.4, temperature: 27, city_type: 'normal',
    country: 'Lebanon', language: 'Lebanese Arabic', currency: 'LBP', weather: {
    temp: [14.0, 14.0, 16.0, 18.7, 21.7, 24.9, 27.1, 27.8, 26.8, 24.1, 19.5, 15.8, 20.9],
    rain: [154, 127, 84, 31, 11, 1, 0.3, 0, 5, 60, 115, 141, 730],
    sunshine: [131, 143, 191, 243, 310, 348, 360, 334, 288, 245, 200, 147, 2940]
  }},
  { city: 'London', latitude: 51.507321899999994, longitude: -0.12764739999999997, overall_score: 7.4, temperature: 21,
    city_type: 'expensive', country: 'UK', language: 'English', currency: 'GBP', weather: {
    temp: [5.2, 5.3, 7.6, 9.9, 13.3, 16.5, 18.7, 18.5, 15.7, 12.0, 8.0, 5.5, 11.3],
    rain: [55.2, 40.9, 41.6, 43.7, 49.4, 45.1, 44.5, 49.5, 49.1, 68.5, 59.0, 55.2, 601.7],
    sunshine: [61.5, 77.9, 114.6, 168.7, 198.5, 204.3, 212.0, 204.7, 149.3, 116.5, 72.6, 52.0, 1632.6]
  }},
  { city: 'Lagos', latitude: 6.455027, longitude: 3.384082, overall_score: 5.2, temperature: 25, city_type: 'cheap',
    country: 'Nigeria', language: 'English', currency: 'NGN', weather: {
    temp: [27.3, 28.4, 28.5, 28.0, 27.0, 25.6, 25.2, 25.0, 25.5, 26.4, 27.2, 27.2, 26.8],
    rain: [13.2, 40.6, 84.3, 146.3, 202.4, 315.5,  243.0, 121.7, 160.0, 125.1, 39.7, 14.8, 1506.6],
    sunshine: [164.3, 168.0, 173.6, 180.0, 176.7, 114.0, 99.2, 108.5, 114.0, 167.4, 186.0, 192.2, 1843.9]
  }},
  { city: 'Cape Town', latitude: -33.925278, longitude: 18.423889, overall_score: 7.2, temperature: 15, city_type: 'normal',
    country: 'South Africa', language: 'English', currency: 'ZAR', weather: {
    temp: [20.4, 20.4, 19.2, 16.9, 14.4, 12.5, 11.9, 12.4, 13.7, 15.6, 17.9, 19.5, 16.2],
    rain: [15, 17, 20, 41, 69, 93, 82, 77, 40, 30, 14, 17, 515],
    sunshine: [337.9, 297.4, 292.9, 233.5, 205.3, 175.4, 193.1, 212.1, 224.7, 277.7, 309.8, 334.2, 3094]
  }},
  { city: 'Gaborone', latitude: -24.658333, longitude: 25.908333, overall_score: 6.2, temperature: 25, city_type: 'cheap',
    country: 'Botswana', language: 'English', currency: 'BWP', weather: {
    temp: [25.7, 25.2, 23.7, 20.6, 16.8, 13.7, 13.5, 16.9, 21.2, 24.0, 24.7, 25.3, 20.9],
    rain: [143, 82, 74, 30, 8.3, 7.5, 1, 0.9, 5.8, 5.8, 58, 71, 487.3],
    sunshine: [235.2, 286.0, 242.1, 240.0, 182.9, 144.0, 303.4, 294.1, 258.1, 155.2, 129.6, 133.5, 2604.1]
  }},
  { city: 'Montevideo', latitude: -34.883611, longitude: -56.181944, overall_score: 8.2, temperature: 15, city_type: 'normal',
    country: 'Uruguay', language: 'Spanish', currency: 'UYU', weather: {
    temp: [23.2, 22.7, 21.3, 17.9, 14.5, 11.7, 11.1, 12.4, 13.7, 16.6, 19.0, 21.5, 17.1],
    rain: [86.8, 101.5, 104.6, 85.5, 89.0, 83.1, 86.4, 88.2, 93.9, 108.5, 89.3, 84.4, 1101.2],
    sunshine: [294.5, 234.5, 220.1, 162.0, 161.2, 126.0, 142.6, 164.3, 180.0, 226.3, 249.0, 282.1, 2442.6]
  }},
  { city: 'Puerto Vallarta', latitude: 20.666667, longitude: -105.266667, overall_score: 7.2, temperature: 25, city_type: 'normal',
    country: 'Mexico', language: 'Spanish', currency: 'MXN', weather: {
    temp: [21.7, 21.7, 22.2, 23.6, 25.6, 28.3, 28.6, 28.3, 28.3, 27.8, 25.3, 22.8, 25.4],
    rain: [33.8, 5.3, 2.0, 1.5, 15.4, 187.6, 328.1,  312.4,  370.0,  93.8, 19.8, 22.5, 1392.2],
    sunshine: [235.2, 286.0, 242.1, 270.0, 132.9, 124.0, 161.9, 148.1, 157.0, 131.2, 197.0, 264.9, 2350.3]
  }},
  { city: 'San José', latitude: 9.933333, longitude: -84.083333, overall_score: 8.5, temperature: 30, city_type: 'cheap',
    country: 'Costa Rica', language: 'Spanish', currency: 'CRC', weather: {
    temp: [22.6, 23.0, 23.5, 23.7, 22.9, 22.5, 22.6, 22.4, 22.0, 21.8, 21.9, 22.3, 22.6],
    rain: [6.3, 10.2, 13.8, 79.9, 267.6,  280.1,  181.5, 276.9,  355.1,  330.6,  135.5, 33.5, 1971],
    sunshine: [285.2, 266.0, 282.1, 240.0, 182.9, 144.0, 151.9, 158.1, 147.0, 161.2, 177.0, 244.9, 2440.3]
  }},
  { city: 'Casablanca', latitude: 33.533333, longitude: -7.583333, overall_score: 6.7, temperature: 20, city_type: 'cheap',
    country: 'Morocco', language: 'Moroccan Arabic', currency: 'MAD', weather: {
    temp: [12.6, 13.7, 15.3, 16.5, 18.5, 20.9, 22.7, 23.2, 22.3, 19.8, 16.5, 14.2, 18.0],
    rain: [68, 45, 38, 40, 15, 3, 1, 1, 9, 37, 86, 74, 415],
    sunshine: [189.6, 188.5, 240.7, 261.5, 293.6, 285.0, 303.4, 294.1, 258.1, 234.3, 190.6, 183.1, 2922.5]
  }},
  { city: 'Colombo', latitude: 6.934444, longitude: 79.842778, overall_score: 7.1, temperature: 25, city_type: 'cheap',
    country: 'Sri Lanka', language: 'Sinhala/English', currency: 'LKR', weather: {
    temp: [26.6, 26.9, 27.7, 28.2, 28.3, 27.9, 27.6, 27.6, 27.5, 27.0, 26.7, 26.6, 27.4],
    rain: [58.2, 72.7, 128.0, 245.6, 392.4,  184.9, 121.9, 119.5, 245.4, 365.4,  414.4,  175.3, 2523.7],
    sunshine: [248.0, 246.4, 275.9, 234.0, 201.5, 195.0, 201.5, 201.5, 189.0, 201.5, 210.0, 217.0, 2621.3]
  }}
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
    weather: hash[:weather],
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
