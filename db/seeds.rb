# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


Role.find_or_create_by(name: "admin")
Role.find_or_create_by(name: "lawyer")
Role.find_or_create_by(name: "client")

Category.find_or_create_by(name: "criminal")
Category.find_or_create_by(name: "civil")
Category.find_or_create_by(name: "corporate")
Category.find_or_create_by(name: "family")

Country.create([{ name: "India", code: "IN" }, { name: "United States", code: "US" }, { name: "United Kingdom", code: "UK" }])
