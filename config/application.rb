require File.expand_path('../boot', __FILE__)

require 'rails/all'
# require "reform/form/active_model/validations"

# Reform::Form.class_eval do
#   include Reform::Form::ActiveModel::Validations
# end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BookShop
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')
  end
end
