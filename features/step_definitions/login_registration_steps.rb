When /^I am trying to register user "([^\"]*)" via (valid|invalid) credentials$/ do |user, choose|
  visit '/'
  click_link('Sign Up')
  if choose == 'valid'
    fill_registrations_fields
  else
    fill_registrations_fields(email: "#{user.downcase}@",
                              first_name: '',
                              last_name: '',
                              password: 'pasdf'
                             )
  end
  click_button('Create User')
  if choose == 'valid'
    expect(page).to have_content("Signed by #{user} Testing")
    expect(User.find_by(email: "#{user.downcase}@mailinator.com")).to_not be_nil
  else
    expect(page).to_not have_content("Signed by #{user} Testing")
    expect(User.find_by(email: "#{user.downcase}@mailinator.com")).to be_nil
  end
end

When /^I should see the next error messages:$/ do |table|
  table.hashes.each do |row|
    find(".#{row['section']}").find('span', text: "#{row['message']}")
  end
end

When /^I should see message "([^\"]*)" in the "([^\"]*)" section$/ do |message, section|
  expect(page.find(".#{section}")).to have_content(message)
end

When /^I am already logged in as user "([^\"]*)" with "([^\"]*)" password$/ do |user, password|
  @user = User.find_by(email: "#{user.downcase}@mailinator.com")
  visit '/'
  click_link('Sign In')
  fill_login_fields(email: @user.email, password: password)
  click_button('Log in')
  expect(page).to have_content("Signed by #{@user.first_name} #{@user.last_name}")
end

When /^I am trying to login with invalid (email|password) for user "([^\"]*)"$/ do |credential, user|
  @user = User.find_by(email: "#{user.downcase}@mailinator.com")
  visit '/'
  click_link('Sign In')
  if credential == 'password'
    fill_login_fields(password: '1234')
  else
    fill_login_fields(email: 'invalid@mailinator.com')
  end
  click_button('Log in')
end

When /^I am trying to edit user "([^\"]*)" infirmation via (valid|invalid) credentials$/ do |user, choose|
  step %{I follow to edit profile page"}
  expect(page).to have_content('Edit User')
  if choose == 'valid'
    fill_registrations_fields(first_name: 'Test')
    fill_in('user_current_password', with: 'p@ssw0rd')
  else
    fill_registrations_fields(email: "#{user.downcase}@",
                              first_name: '',
                              last_name: '',
                              password: 'pasdf'
                             )
    fill_in('user_current_password', with: 'p@ssw0rd')
  end
  step %{I press button "Update User"}
  if choose == 'valid'
    expect(page).to have_content("Signed by Test Testing")
  else
    expect(page).to have_content("Signed by #{user} Testing")
  end
end

When /^I am trying to change user "([^\"]*)" with "([^\"]*)" password$/ do |user, password|
  step %{I follow to edit profile page"}
  expect(page).to have_content('Edit User')
  fill_registrations_fields(password: password, password_confirmation: password)
  fill_in('user_current_password', with: 'p@ssw0rd')
  step %{I press button "Update User"}
  expect(page).to have_content("Signed by #{user} Testing")
end

When /^I follow to edit profile page/ do
  step %{I press link "Account"}
  step %{I press link "Edit Profile"}
end

def fill_registrations_fields(email: 'dave@mailinator.com',
                              first_name: 'Dave',
                              last_name: 'Testing',
                              password: 'p@ssw0rd',
                              password_confirmation: 'p@ssw0rd'
                              )
  fill_in('user_email', with: email)
  fill_in('user_first_name', with: first_name)
  fill_in('user_last_name', with: last_name)
  fill_in('user_password', with: password)
  fill_in('user_password_confirmation', with: password_confirmation)
end

def fill_login_fields(email: 'dave@mailinator.com', password: 'p@ssw0rd')
  expect(page).to have_content('Please login')
  sleep 0.5 #need a good decigion for stable tests with animation
  fill_in('user_email', with: email)
  fill_in('user_password', with: password)
end
