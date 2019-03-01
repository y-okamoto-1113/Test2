# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

# js,css読み込む為のコード
Rails.application.config.assets.precompile += %w( buttons.js )
Rails.application.config.assets.precompile += %w( new.css )
Rails.application.config.assets.precompile += %w( modal.css )
# inspinia
Rails.application.config.assets.precompile += %w( inspinia/bootstrap.min.css )
Rails.application.config.assets.precompile += %w( inspinia/font-awesome.css )
Rails.application.config.assets.precompile += %w( inspinia/style.css )
Rails.application.config.assets.precompile += %w( inspinia/animate.css )
Rails.application.config.assets.precompile += %w( inspinia/jquery-3.1.1.min.js )
Rails.application.config.assets.precompile += %w( inspinia/bootstrap.min.js )
