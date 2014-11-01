# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    body "MyAnswer"
    association :question
    association :user
  end

  factory :invalid_answer, class: "Answer" do
    body nil
    association :question
    association :user
  end
end
