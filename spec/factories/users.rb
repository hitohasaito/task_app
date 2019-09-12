FactoryBot.define do
  factory :user do
    name { "name1" }
    email { |n| "name1#{n}@example.com"}
    password { "passwordpassword1" }
    password_confirmation { "passwordpassword1" }
  end

  factory :second_user, class:User do
    name { "name2" }
    email { |n| "name2#{n}@example.com"}
    password { "passwordpassword2" }
    password_confirmation { "passwordpassword2" }
  end
end
