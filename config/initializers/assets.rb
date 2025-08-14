# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

Rails.application.config.assets.precompile += %w[*.png *.ico]
Rails.application.config.assets.precompile += %w[.svg .eot .woff .ttf .woff2 .woff]
Rails.application.config.assets.precompile += %w[confirmation-print.css ie8.css ie7.css]
Rails.application.config.assets.precompile += ['govuk-frontend/dist/govuk/all.css']
Rails.application.config.assets.precompile += ['govuk-frontend/dist/govuk/govuk-frontend.min.js']
Rails.application.config.assets.precompile += ['govuk-frontend/dist/govuk/all-ie8.css']
Rails.application.config.assets.precompile += ['govuk-frontend/dist/govuk/assets/images/favicon.ico']
Rails.application.config.assets.precompile += ['govuk-frontend/dist/govuk/assets/rebrand/images/favicon.ico']
Rails.application.config.assets.precompile += ['govuk-frontend/dist/govuk/assets/images/favicon.svg']
Rails.application.config.assets.precompile += ['govuk-frontend/dist/govuk/assets/rebrand/images/favicon.svg']
Rails.application.config.assets.precompile += ['govuk-frontend/dist/govuk/assets/images/govuk-icon-mask.svg']
Rails.application.config.assets.precompile += ['govuk-frontend/dist/govuk/assets/rebrand/images/govuk-icon-mask.svg']
Rails.application.config.assets.precompile += ['govuk-frontend/dist/govuk/assets/images/govuk-icon-180.png']
Rails.application.config.assets.precompile += ['govuk-frontend/dist/govuk/assets/rebrand/images/govuk-icon-180.png']
Rails.application.config.assets.precompile += ['govuk-frontend/dist/govuk/assets/fonts/*']
