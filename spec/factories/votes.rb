FactoryGirl.define do
  factory :vote do
    score 0
    association :user
  end

end
