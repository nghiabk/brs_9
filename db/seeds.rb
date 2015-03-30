# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create! email: "example@gmail.com", username: "example", password: "12345678", role: "admin"
99.times do |n|
  username = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  User.create! email: email, username: username, password: "12345678", role: "user"
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }