When /^I wait "([^\"]*)"$/ do |seconds|
  sleep(seconds.to_i)
end

When /^I press (link|button) "([^\"]*)"$/ do |action, name|
  action == 'button' ? click_button(name) : click_link(name)
end

When /^I press (link|button) "([^\"]*)" with element$/ do |action, name|
  # find better fix for clicking links that contains another elements by poltergeist
  if ENV['DRIVER'] == "selenium"
    step %{I press #{action} "#{name}"}
  else
    action == 'button' ? first("button", text: name).trigger('click') : first("a", text: name).trigger('click')
  end
end

When /^I press (link|button) with class "([^\"]*)"$/ do |element, name|
  if element == 'button'
    first("button.#{name}").click
  else
    first("a.#{name}").click
  end
end

And /^I should be in (root|projects) page$/ do |page|
  sleep 0.5 #TODO need better way for delay path expectation
  expect(current_path).to eq(send("#{page}_path"))
end

When /^I logout$/ do
  #TODO fix that in phantomJS
  sleep 0.5
  step %{I press link "Sign Out"}
  sleep 0.5
end

When /^I make screenshot "([^\"]*)"/ do |title|
  time_now = Time.now.strftime('%Y-%m-%d_%H-%M-%S_%L')
  title = "_#{title}" if title.present?
  name = "features/screen_shots/#{time_now}#{title.underscore}.png"
  page.driver.render(name, :full => true)
end

And /^I should see in the "([^\"]*)" section:$/ do |section, table|
  table.hashes.each do |row|
    expect(page.find(".#{section}")).to have_content(row['content'])
  end
end