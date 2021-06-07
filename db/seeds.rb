# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts "Creating users"

User.destroy_all
Country.destroy_all
City.destroy_all
Review.destroy_all
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

puts "Creating 30 cities"
30.times do |i|
  city = City.create!(
    country: Country.all.sample,
    name: Faker::Address.unique.city,
    coordinates: "lat #{Faker::Address.latitude} long #{Faker::Address.longitude} ",
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

puts "Creating 50 wishlists"
50.times do |i|
  Wishlist.create!(
    city: City.all.sample,
    user: User.all.sample
    )
end

puts 'Finished!'
