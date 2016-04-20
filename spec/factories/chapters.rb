FactoryGirl.define do
  factory :chapter do
    sequence(:title) { |n| "Chapter #{n}" }
  end

end
