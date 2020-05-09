# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

Rails.application.config.assets.precompile += %w( admin.css admin.js )
Rails.application.config.assets.precompile += %w( user.css user.js )
Rails.application.config.assets.precompile += %w( masseur.css masseur.js )
Rails.application.config.assets.precompile += %w( store_manager.css store_manager.js )
Rails.application.config.assets.precompile += %w( store_managers.css store_managers.js )

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
