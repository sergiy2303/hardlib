FactoryGirl.define do
  factory :project do
    sequence(:title) { |n| "Project #{n}" }
    description { 'Test description' }
  end

end
