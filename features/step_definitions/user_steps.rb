When /^I have a user "([^"]*)"$/ do |user|
  @user = FactoryGirl.create(
    :user,
    email: "#{user.downcase}@mailinator.com",
    first_name: user,
    last_name: "Testing"
  )
end

And /^User "([^"]*)" should have:$/ do |user, table|
  @user = User.find_by(email: "#{user.downcase}@mailinator.com")
  table.hashes.each do |row|
    row.each do |key, value|
      expect(@user.send(key).count).to eq(value.to_i)
    end
  end
end

