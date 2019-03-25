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
Rails.application.config.assets.precompile += %w( jquery.quicksearch.js )
Rails.application.config.assets.precompile += %w( new.css )
Rails.application.config.assets.precompile += %w( modal.css )
Rails.application.config.assets.precompile += %w( school.json )
# inspinia
# Rails.application.config.assets.precompile += %w( style.scss )
# Rails.application.config.assets.precompile += %w( animate.css )
# Rails.application.config.assets.precompile += %w( bootstrap.min.css )
# Rails.application.config.assets.precompile += %w( font-awesome.css )
# Rails.application.config.assets.precompile += %w( inspinia/jquery-3.1.1.min.js )
# Rails.application.config.assets.precompile += %w( inspinia/bootstrap.min.js )
# Rails.application.config.assets.precompile += %w( login.css )
# Rails.application.config.assets.precompile += %w( login01.css )
# icheck
Rails.application.config.assets.precompile += %w( ui/icheck-1.0.2/skins/square/green.css )
Rails.application.config.assets.precompile += %w( ui/icheck-1.0.2/icheck.min.js )
Rails.application.config.assets.precompile += %w( icheck.min.js )

