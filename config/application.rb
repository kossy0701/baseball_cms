require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module BaseballCms
  class Application < Rails::Application
    config.load_defaults 5.2
    config.generators.system_tests = nil
    config.time_zone = 'Tokyo'
    config.i18n.default_locale = :ja
    config.active_record.default_timezone = :local
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]

    config.generators do |g|
      g.template_engine  :haml
      g.test_framework   :rspec, fixture: false
      g.view_specs       false
      g.controller_specs false
      g.helper           false
      g.stylesheets      false
      g.javascripts      false
    end
  end
end
