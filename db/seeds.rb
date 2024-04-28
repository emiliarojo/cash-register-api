# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Product.find_or_create_by!(code: 'GR1', name: "Green Tea", price: 3.11, bogo_eligible: true)
Product.find_or_create_by!(code: 'SR1', name: "Strawberries", price: 5.00, bulk_eligible: true, bulk_threshold: 3, new_price: 4.50)
Product.find_or_create_by!(code: 'CF1', name: "Coffee", price: 11.23, bulk_eligible: true, bulk_threshold: 3, discount_factor: 2/3.0)

puts "Seeded products"
