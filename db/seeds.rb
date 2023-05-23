# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.destroy_all
puts "User destroyed"
Word.destroy_all
puts "Word destroyed"

User.create!(email: "g@gmail.com", password: "testtesttest")
puts "User created."
Word.create!(user: User.first, title: "hi", description: "greeting")
puts "Word created."
