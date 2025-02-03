# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Create root category
electronics = Category.create(name: "Electronics")
mobiles = electronics.children.create(name: "Mobile Phones")
samsung = mobiles.children.create(name: "Samsung")

# Add a product under Samsung category
Product.create(name: "Samsung Galaxy S23", category: samsung, price: 999.99, stock_quantity: 10)
