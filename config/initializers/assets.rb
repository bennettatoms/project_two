# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path
AlchemyAPI.configure do |config|
  config.apikey = "1543b723d6070c33bd54385f64f7b05b69c595c9"
  config.output_mode = :json # not yet supported
end
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( vendor/modernizr.js )