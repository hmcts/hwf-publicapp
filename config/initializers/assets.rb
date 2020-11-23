# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.1'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w[*.png *.ico]
Rails.application.config.assets.precompile += %w[.svg .eot .woff .ttf .woff2 .woff]
Rails.application.config.assets.precompile += %w[confirmation-print.css ie8.css ie7.css]
Rails.application.config.assets.precompile += ['govuk-frontend/govuk/all.css']
Rails.application.config.assets.precompile += ['govuk-frontend/govuk/all.js']
Rails.application.config.assets.precompile += ['govuk-frontend/govuk/all-ie8.css']
Rails.application.config.assets.precompile += ['govuk-frontend/govuk/assets/images/favicon.ico']
Rails.application.config.assets.precompile += ['govuk-frontend/govuk/assets/images/govuk-apple-touch-icon-152x152.png']
Rails.application.config.assets.precompile += ['govuk-frontend/govuk/assets/images/govuk-apple-touch-icon-167x167.png']
Rails.application.config.assets.precompile += ['govuk-frontend/govuk/assets/images/govuk-apple-touch-icon-180x180.png']
Rails.application.config.assets.precompile += ['govuk-frontend/govuk/assets/images/govuk-apple-touch-icon.png']
Rails.application.config.assets.precompile += ['govuk-frontend/govuk/assets/images/govuk-crest-2x.png']
Rails.application.config.assets.precompile += ['govuk-frontend/govuk/assets/images/govuk-crest.png']
Rails.application.config.assets.precompile += ['govuk-frontend/govuk/assets/images/govuk-logotype-crown.png']
Rails.application.config.assets.precompile += ['govuk-frontend/govuk/assets/images/govuk-mask-icon.svg']
Rails.application.config.assets.precompile += ['govuk-frontend/govuk/assets/images/govuk-opengraph-image.png']
