# Be sure to restart your server when you modify this file.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( pagination.css ) # Style for pagination
Rails.application.config.assets.precompile += %w( jquery.zoom.min.js ) # Zoom for images
Rails.application.config.assets.precompile += %w( xml2html.js ) # Visualise the tags from XML
Rails.application.config.assets.precompile += %w( prettify.js ) # Style for the xml code
