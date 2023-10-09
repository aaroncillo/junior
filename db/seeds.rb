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
producto1 = Product.create!(tipo_producto: "Plancha1", precio: 10000, cantidad: 10, user_id: usuario1_admin.id)
producto2 = Product.create!(tipo_producto: "Plancha2", precio: 8000, cantidad: 5, user_id: usuario1_admin.id)
producto3 = Product.create!(tipo_producto: "Plancha3", precio: 5000, cantidad: 3, user_id: usuario1_admin.id)
producto4 = Product.create!(tipo_producto: "Plancha4", precio: 3000, cantidad: 2, user_id: usuario1_admin.id)
producto5 = Product.create!(tipo_producto: "Plancha5", precio: 1000, cantidad: 1, user_id: usuario1_admin.id)

#Create a 5 different products of other admin
producto6 = Product.create!(tipo_producto: "Madera1", precio: 10000, cantidad: 10, user_id: usuario2_admin.id)
producto7 = Product.create!(tipo_producto: "Madera2", precio: 5000, cantidad: 10, user_id: usuario2_admin.id)
producto8 = Product.create!(tipo_producto: "Madera3", precio: 5000, cantidad: 10, user_id: usuario2_admin.id)
producto9 = Product.create!(tipo_producto: "Madera4", precio: 10000, cantidad: 10, user_id: usuario2_admin.id)
producto10 = Product.create!(tipo_producto: "Madera5", precio: 500, cantidad: 10, user_id: usuario2_admin.id)

#Create a sales of salers

venta1 = Sale.create!(cantidad: 1, fecha: "2021-08-01", user_id: usuario1_saler.id, product_id: producto1.id)
venta2 = Sale.create!(cantidad: 2, fecha: "2021-08-02", user_id: usuario1_saler.id, product_id: producto2.id)
venta3 = Sale.create!(cantidad: 3, fecha: "2021-08-03", user_id: usuario1_saler.id, product_id: producto3.id)
venta4 = Sale.create!(cantidad: 4, fecha: "2021-08-04", user_id: usuario1_saler.id, product_id: producto4.id)
venta5 = Sale.create!(cantidad: 5, fecha: "2021-08-05", user_id: usuario1_saler.id, product_id: producto5.id)

venta6 = Sale.create!(cantidad: 6, fecha: "2021-08-06", user_id: usuario2_saler.id, product_id: producto6.id)
venta7 = Sale.create!(cantidad: 7, fecha: "2021-08-07", user_id: usuario2_saler.id, product_id: producto7.id)
venta8 = Sale.create!(cantidad: 8, fecha: "2021-08-08", user_id: usuario2_saler.id, product_id: producto8.id)
venta9 = Sale.create!(cantidad: 9, fecha: "2021-08-09", user_id: usuario2_saler.id, product_id: producto9.id)
venta10 = Sale.create!(cantidad: 10, fecha: "2021-08-10", user_id: usuario2_saler.id, product_id: producto10.id)
