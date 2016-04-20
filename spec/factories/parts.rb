FactoryGirl.define do
  factory :part do
    sequence(:title) { |n| "Chapter #{n}" }
    body { 'Test body for part' }
  end

end
