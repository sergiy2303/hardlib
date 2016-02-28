require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hardlib
  class Application < Rails::Application
    Rails.configuration.cloudinary = YAML.load(ERB.new(File.read('config/cloudinary.yml')).result)[Rails.env]
    config.active_record.raise_in_transactional_callbacks = true
  end
end
