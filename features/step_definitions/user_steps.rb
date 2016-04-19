When /^I have a user "([^"]*)"$/ do |user|
  @user = FactoryGirl.create(
    :user,
    :email => "#{user.downcase}@mailinator.com",
    :first_name => user,
    :last_name => "Testing"
  )
end

