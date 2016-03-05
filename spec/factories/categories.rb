FactoryGirl.define do
  factory :category do
    sequence(:title) { |n| "#{n}category" }
  end
end
