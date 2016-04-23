When /^I am trying to create (project|chapter|part):$/ do |item, table|
  click_link("New #{item}")
  table.hashes.each do |row|
    row.each do |key, value|
      fill_in(key, with: value)
    end
  end
  click_button("Create #{item.capitalize}")
end

When /^I follow to "([^\"]*)" page$/ do |page|
  step %{I press link "Account"}
  click_link(page)
end

When /^User "([^\"]*)" have folowing project structure:$/ do |user, table|
  @user = User.find_by(email: "#{user.downcase}@mailinator.com")
  table.hashes.each do |row|
    project = find_or_create_project('Project', row['Project'])
    chapter = FactoryGirl.create(:chapter, project: project, title: row['Chapter'])
    part = FactoryGirl.create(:part, chapter: chapter, title: row['Part'])
  end
end

When /^I am trying to share project "([^\"]*)" with user "([^\"]*)"$/ do |project, user|
  step %{I press link "Share project"}
  fill_in('email', with: "#{user.downcase}@mailinator.com")
  step %{I press button "Share"}
end

def find_or_create_project(type, value)
  Object.const_get(type).find_by(title: value) || FactoryGirl.create(type.downcase.to_sym, user: @user, title: value)
end