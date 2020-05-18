require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SmartReservation
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
<<<<<<< HEAD
<<<<<<< HEAD
    config.time_zone = 'Asia/Tokyo'
    config.i18n.default_locale = :ja
    config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

=======
    config.hosts << "4e4f46ca4b3a4ef899198d33ffe60ac0.vfs.cloud9.us-east-2.amazonaws.com"
>>>>>>> b5bc804... googleログイン機能実装
=======
    config.hosts << "4e4f46ca4b3a4ef899198d33ffe60ac0.vfs.cloud9.us-east-2.amazonaws.com"
>>>>>>> b5bc804... googleログイン機能実装
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    
    # RSpecの設定、無駄なファイルを生成しない
    config.generators do |g|
      g.test_framework :rspec,
        view_specs: false,
        helper_specs: false,
        routing_specs: false
    end
    config.autoloader = :classic

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
