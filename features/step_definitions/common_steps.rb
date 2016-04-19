When /^I wait "([^\"]*)"$/ do |seconds|
  sleep(seconds.to_i)
end

When /^I press (link|button) "([^\"]*)"$/ do |action, name|
  action == 'button' ? click_button(name) : click_link(name)
end

When /^I press (link|button) with class "([^\"]*)"$/ do |element, name|
  if element == 'button'
    first("button.#{name}").click
  else
    first("a.#{name}").click
  end
end