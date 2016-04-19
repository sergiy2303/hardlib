require 'cucumber/rails'
require 'capybara/poltergeist'

ActionController::Base.allow_rescue = false
#if you wand to use selenium webdriver set enviroment variable like here: DRIVER=selenium rake cucumber
Capybara.javascript_driver = ENV['DRIVER'] == "selenium" ? :selenium : :poltergeist

Before('@javascript') do
  Capybara.current_session.driver.browser.manage.window.resize_to(1366, 768) if Capybara.javascript_driver == :selenium
end

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Cucumber::Rails::Database.javascript_strategy = :truncation

