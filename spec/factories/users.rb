FactoryBot.define do

  factory :user do
    id { 1 }
    name { "name1" }
    email { "name1@email.com"}
    password { "password1" }
    password_confirmation { "password1" }
  end

  factory :second_user, class:User do
    id { 2 }
    name { "name2" }
    email { "name2@email.com"}
    password { "password2" }
    password_confirmation { "password2" }
  end

  factory :third_user, class:User do
    id { 3 }
    name { "name33" }
    email { "name33@email.com"}
    password { "password33" }
    password_confirmation { "password33" }
  end
end
