FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@mailinator.com" }
    password { 'p@ssw0rd' }
    first_name { 'Dave' }
    last_name { 'Doe' }
  end
end
