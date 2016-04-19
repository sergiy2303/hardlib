When /^I wait "([^\"]*)"$/ do |seconds|
  sleep(seconds.to_i)
end