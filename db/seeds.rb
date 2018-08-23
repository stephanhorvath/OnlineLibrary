# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
require 'faker'
# require 'stripe'
Faker::Config.locale = 'gb'

# plan = Stripe::Plan.create({
#   product:   Stripe::Product.create(
#                  :name => 'Unlimited Membership 2',
#                  :type => 'service'
#                ),
#   amount: 800,
#   interval: 'month',
#   nickname: 'Unlimited Plan - Paperback 2',
#   currency: 'gbp',
#   id: 'Paperback 2'
# })

# plan = Stripe::Plan.create({
#   product: Stripe::Product.create(
#              :name => 'Unlimited Membership 4',
#              :type => 'service'
#            ),
#   amount:   1200,
#   interval: 'month',
#   nickname: 'Unlimited Plan - Paperback 4',
#   currency: 'gbp',
#   id:       'Paperback 4'
# })

# plan = Stripe::Plan.create({
#   product: Stripe::Product.create(
#              :name => 'Unlimited Membership 6',
#              :type => 'service'
#            ),
#   amount:    1900,
#   interval:  'month',
#   nickname:  'Unlimited Plan - Paperback 6',
#   currency:  'gbp',
#   id:        'Paperback 6'
# })

# plan = Stripe::Plan.create({
#   product: "prod_CndgIvh9vKtE7y",
#   amount: 1000,
#   interval: 'month',
#   nickname: 'Unlimited Plan - Audiobook 2',
#   currency: 'gbp',
#   id: 'Audiobook 2'
# })

# plan = Stripe::Plan.create({
#   product: "prod_CndsaQgO7YERUx",
#   amount: 1250,
#   interval: 'month',
#   nickname: 'Unlimited Plan - Audiobook 4',
#   currency: 'gbp',
#   id: 'Audiobook 4'
# })
# 
# plan = Stripe::Plan.create({
#   product: "prod_CndyFOrEbiiOuN",
#   amount: 1900,
#   interval: 'month',
#   nickname: 'Unlimited Plan - Audiobook 6',
#   currency: 'gbp',
#   id: 'Audiobook 6'
# })

plan1 = Plan.create(product: "prod_CndgIvh9vKtE7y", nickname: "Unlimited Plan - Paperback 2", stripe_id: "Paperback 2", display_price: (800.to_f / 100), book_limit: 2)

plan2 = Plan.create(product: "prod_CndsaQgO7YERUx", nickname: "Unlimited Plan - Paperback 4", stripe_id: "Paperback 4", display_price: (1200.to_f / 100), book_limit: 4)

plan3 = Plan.create(product: "prod_CndyFOrEbiiOuN", nickname: "Unlimited Plan - Paperback 6", stripe_id: "Paperback 6", display_price: (1900.to_f / 100), book_limit: 6)

plan4 = Plan.create(product: "prod_CndgIvh9vKtE7y", nickname: "Unlimited Plan - Audiobook 2", stripe_id: "Audiobook 2", display_price: (1000.to_f / 100), book_limit: 2)

plan5 = Plan.create(product: "prod_CndsaQgO7YERUx", nickname: "Unlimited Plan - Audiobook 4", stripe_id: "Audiobook 4", display_price: (1250.to_f / 100), book_limit: 4)

plan6 = Plan.create(product: "prod_CndyFOrEbiiOuN", nickname: "Unlimited Plan - Audiobook 6", stripe_id: "Audiobook 6", display_price: (1900.to_f / 100), book_limit: 6)

User.create!(first_name: "Stephan",
             last_name: "Horvath",
             address_line_1: "1 High Street",
             address_line_2: nil,
             town: "Glasgow",
             post_code: "G12 3AB",
             tel_no: "07777777777",
             email: "stephan@readall.com",
             password: "password",
             password_confirmation: "password",
             type: "Manager")

Member.create!(first_name: "James",
               last_name: "Waller",
               address_line_1: "1 Stirling Avenue",
               address_line_2: "Flat 9",
               town: "Stirling",
               post_code: "FK2 9LK",
               tel_no: "01411111111",
               email: "james@readall.com",
               password: "password",
               password_confirmation: "password",
               type: "Member",
               plan: Plan.first)

20.times do |m|
  first_name =            Faker::Name.first_name
  last_name =             Faker::Name.last_name
  address_line_1 =        Faker::Address.street_address + " " + Faker::Address.street_suffix
  address_line_2 =        Faker::Address.secondary_address
  town =                  Faker::Address.town
  post_code =             Faker::Address.post_code
  tel_no =                "01412222222"
  email =                 Faker::Internet.safe_email(first_name)
  password =              "password"
  password_confirmation = "password"
  type =                  "Member"
  plan =                  Plan.find(rand(1..3))
  Member.create!(first_name: first_name,
                 last_name: last_name,
                 address_line_1: address_line_1,
                 address_line_2: address_line_2,
                 town: town,
                 post_code: post_code,
                 tel_no: tel_no,
                 email: email,
                 password: password,
                 password_confirmation: password_confirmation,
                 type: type,
                 plan: plan)
end

10.times do |s|
  name = Faker::Company.name
  url  = Faker::Internet.url
  Supplier.create!(name: name,
                   url:  url)
end

Supplier.create!(name: "Amazon",
                 url: "https://amazon.co.uk")

Book.create!(title: "Dune",
             description: "A sandy planet with spice",
             genre: "sci-fi",
             publisher: "Hodder",
             supplier_id: 1,
             type: "Book",
             author: "Frank Herbert",
             stock: 1)

Book.create!(title: "How to Kill a Mockingbird",
             description: "Bye-bye Birdie",
             genre: "drama",
             publisher: "Penguin",
             supplier_id: 1,
             type: "Book",
             author: "Harper Lee",
             stock: 2)

98.times do |b|
  title = Faker::Book.title
  description = "Generated with Faker::Book"
  genre = Faker::Book.genre
  publisher = Faker::Book.publisher
  supplier_id = rand(1..10)
  type = "Book"
  author = Faker::Book.author
  stock = rand(0..3)
  Book.create!(title: title,
               description: description,
               genre: genre,
               publisher: publisher,
               supplier_id: supplier_id,
               type: type,
               author: author,
               stock: stock)
end

begin_date = DateTime.now
returned   = false

Loan.create!(begin_date: begin_date,
             returned: returned,
             user_id: 2,
             status: "shipped")

Loan.create!(begin_date: begin_date,
             returned: returned,
             user_id: 2,
             status: "placed")

LoanLine.create!(loan_id: 1,
                 book_id: 1)

LoanLine.create!(loan_id: 2,
                 book_id: 2)


