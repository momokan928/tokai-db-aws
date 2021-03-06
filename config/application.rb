require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TokaiDatabase
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil

    # 7/14追加　　https://qiita.com/Ushinji/items/522ed01c9c14b680222c
    config.generators do |g|
      g.test_framework :rspec, 
            view_specs: false, 
            helper_specs: false, 
            controller_specs: false, 
            routing_specs: false
    end

    # 日本語設定
    config.time_zone = 'Tokyo'
    config.i18n.default_locale = :ja

    config.hosts << "localhost"
    #heroku
    config.hosts << "tokai-onair.herokuapp.com"
    config.hosts << "www.tokai-onair.work"

    #AWS
    config.hosts << "3.128.212.54"
    config.hosts << "tokai-database-219787774.us-east-2.elb.amazonaws.com"
    config.hosts << "www.tokaionair.cf"
    config.hosts << "toukaionair.com"
    
  end
end
