# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "user#{n}@test.com" }
    sequence(:name) { |n| "UserName#{n}" }

    password '12345678'
    password_confirmation '12345678'
  end
end
