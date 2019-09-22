10.times do |artist|
  name = Faker::Artist.name
  email = Faker::Internet.email
  password = "password"
  admin = "true"
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password)
end

3.times do |animal|
  name = Faker::Creature::Animal.name
  email = Faker::Internet.email
  password = "password"
  admin = "true"
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password,
              admin: true)
end
