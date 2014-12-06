FactoryGirl.define do
  factory :comment do
    body "Comment body text"
    commentable_id 1
    commentable_type "MyString"
    association :user
  end

end
