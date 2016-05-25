When /^I am trying to create (project|chapter|part):$/ do |item, table|
  click_link("New #{item}")
  table.hashes.each do |row|
    row.each do |key, value|
      if key == "Body"
        tinymce_fill_in('part_body', with: value)
      else
        fill_in(key, with: value)
      end
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
    project = find_or_create_project(row['Project'])
    chapter = find_or_create_chapter(project, row['Chapter'])
    part = FactoryGirl.create(:part, chapter: chapter, title: row['Part'])
  end
end

When /^I am trying to share project "([^\"]*)" with user "([^\"]*)"$/ do |project, user|
  step %{I press link "Share project"}
  fill_in('email', with: "#{user.downcase}@mailinator.com")
  step %{I press button "Share"}
end

And /^I am trying to delete (project|chapter|part) "([^\"]*)"$/ do |type, title|
  find(:css, 'a', text: title).find(:xpath, '..').click_link("Delete #{type}")
  if page.driver.browser.respond_to?(:switch_to)
    expect(page.driver.browser.switch_to.alert.text).to eq("Are you sure want to delete this #{type}?")
    page.driver.browser.switch_to.alert.accept
  else
    expect(page.driver.browser.modal_message).to eq("Are you sure want to delete this #{type}?")
    page.driver.browser.accept_confirm
  end
  expect(page).to_not have_content(title)
end

And /^I am trying to edit (project|chapter|part) "([^\"]*)" with title "([^\"]*)" and text "([^\"]*)"$/ do |type, title, new_title, text|
  find(:css, 'a', text: title).find(:xpath, '..').click_link("Edit #{type}")
  fill_in('Title', with: new_title)
  tinymce_fill_in('part_body', with: text) if type == 'part'
  step %{I press button "Update #{type.capitalize}"}
  expect(page).to have_content(new_title)
  expect(page).to have_content(text)
end

And /^User "([^\"]*)" should not have items$/ do |user|
  @user = User.find_by(email: "#{user.downcase}@mailinator.com")
  expect(@user.projects.count).to be(0)
  expect(@user.chapters.count).to be(0)
  expect(@user.parts.count).to be(0)
end

def find_or_create_project(value)
  Project.find_by(title: value) || FactoryGirl.create(:project, user: @user, title: value)
end

def find_or_create_chapter(project, value)
  Chapter.find_by(title: value) || FactoryGirl.create(:chapter, project: project, user: @user, title: value)
end

def tinymce_fill_in (name, options = {})
  if ENV['DRIVER'].present?
    page.driver.browser.switch_to.frame("#{name}_ifr")
    page.find(:css, '#tinymce').native.send_keys(options[:with])
    page.driver.browser.switch_to.default_content
  else
    page.execute_script("tinyMCE.get('#{name}').setContent('#{options[:with]}')")
  end
end
