# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Path: db/seeds.rb

# Create a 2 users admins
usuario1_admin = User.create!(email: "junior@gmail.com", password: "123456", name: "Junior", role: "admin")
usuario2_admin = User.create!(email: "felipe@gmail.com", password: "123456", name: "Felipe", role: "admin")

#Create a 2 users salers
usuario1_saler = User.create!(email: "karen@gmail.com", "password": "123456", name: "Karen", role: "saler")
usuario2_saler = User.create!(email: "viviana@gmail.com", "password": "123456", name: "Viviana", role: "saler")

#Create a 5 different products of one admin
producto1 = Product.create!(tipo_producto: "Pichanguera", precio: 24000, cantidad: 15, user_id: usuario1_admin.id)
producto2 = Product.create!(tipo_producto: "Clásica", precio: 22000, cantidad: 10, user_id: usuario1_admin.id)
producto3 = Product.create!(tipo_producto: "Individual Alta", precio: 14000, cantidad: 20, user_id: usuario1_admin.id)
producto4 = Product.create!(tipo_producto: "Set Atizadores", precio: 14000, cantidad: 8, user_id: usuario1_admin.id)

#Create a 5 different products of other admin
producto6 = Product.create!(tipo_producto: "Toro", precio: 12000, cantidad: 30, user_id: usuario2_admin.id)
producto7 = Product.create!(tipo_producto: "Letrero 90", precio: 24000, cantidad: 10, user_id: usuario2_admin.id)
producto8 = Product.create!(tipo_producto: "Letrero 55", precio: 15000, cantidad: 20, user_id: usuario2_admin.id)
producto9 = Product.create!(tipo_producto: "Letrero 40", precio: 10000, cantidad: 15, user_id: usuario2_admin.id)
producto10 = Product.create!(tipo_producto: "Letrero 23", precio: 10000, cantidad: 15, user_id: usuario2_admin.id)
producto11 = Product.create!(tipo_producto: "Letrero Toro", precio: 39000, cantidad: 2, user_id: usuario2_admin.id)
producto12 = Product.create!(tipo_producto: "Letrero Circular", precio: 10000, cantidad: 9, user_id: usuario2_admin.id)
