When /^I am already logged in as user "([^\"]*)"$/ do |user|
  @user = User.find_by(email: "#{user.downcase}@mailinator.com")
  visit '/'
  click_link('Sign In')
  fill_in('user_email', with: @user.email)
  fill_in('user_password', with: 'p@ssw0rd')
  click_button('Log in')
  expect(page).to have_content("Signed by #{@user.first_name} #{@user.last_name}")
end