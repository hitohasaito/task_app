FactoryBot.define do

  factory :user do
    name { "name1" }
    email { "name1@email.com"}
    password { "password1" }
    password_confirmation { "password1" }
  end

  factory :second_user, class:User do
    name { "name2" }
    email { "name2@email.com"}
    password { "password2" }
    password_confirmation { "password2" }
  end
end
