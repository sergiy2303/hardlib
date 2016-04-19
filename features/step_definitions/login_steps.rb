When /^I am trying to register user "([^\"]*)"$/ do |user|
  visit '/'
  click_link('Sign Up')
  fill_in('user_email', with: "#{user.downcase}@mailinator.com")
  fill_in('user_first_name', with: user)
  fill_in('user_last_name', with: 'Testing')
  fill_in('user_password', with: 'p@ssw0rd')
  fill_in('user_password_confirmation', with: 'p@ssw0rd')
  click_button('Create User')
  expect(page).to have_content("Signed by #{user} Testing")
  expect(User.find_by(email: "#{user.downcase}@mailinator.com")).to_not be_nil
end

When /^I am trying to register user "([^\"]*)" via invalid credentials$/ do |user|
  visit '/'
  click_link('Sign Up')
  fill_in('user_email', with: "#{user.downcase}@")
  fill_in('user_first_name', with: '')
  fill_in('user_last_name', with: '')
  fill_in('user_password', with: 'p@ssw0rd2')
  fill_in('user_password_confirmation', with: 'p@ssw0rd')
  click_button('Create User')
  expect(page).to_not have_content("Signed by #{user} Testing")
  expect(User.find_by(email: "#{user.downcase}@mailinator.com")).to be_nil
end

When /^I should see the next error messages:$/ do |table|
  table.hashes.each do |row|
    find(".#{row['section']}").find('span', text: "#{row['message']}")
  end
end

When /^I am already logged in as user "([^\"]*)"$/ do |user|
  @user = User.find_by(email: "#{user.downcase}@mailinator.com")
  visit '/'
  click_link('Sign In')
  expect(page).to have_content('Please login')
  fill_in('user_email', with: @user.email)
  fill_in('user_password', with: 'p@ssw0rd')
  click_button('Log in')
  expect(page).to have_content("Signed by #{@user.first_name} #{@user.last_name}")
end
