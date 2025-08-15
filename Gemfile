# frozen_string_literal: true
# Fabulous Shiny Gems!

# Require Bundler 2.7.1 or newer
BUNDLER_VERSION = Gem::Version.new(Bundler::VERSION)
MIN_BUNDLER = Gem::Version.new('2.7.1')
abort "Bundler #{MIN_BUNDLER} or newer is required. You have #{BUNDLER_VERSION}." if BUNDLER_VERSION < MIN_BUNDLER

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.9'
gem 'rails', '8.0.2'

# Core
gem 'pg', '~> 1.5'                  # Rails 8 compatible
gem 'puma', '~> 6.4'                # Puma 6.x for Rails 8
gem 'bootsnap', '>= 1.4.2'

# Auth / uploads / misc
gem 'devise', '~> 4.9'
gem 'bcrypt', '~> 3.1', '>= 3.1.13'
gem 'carrierwave', '~> 2.2'
gem 'fog-aws', '~> 3.5', '>= 3.5.2'
gem 'image_processing', '~> 1.10', '>= 1.10.3'
gem 'jbuilder', '~> 2.11'
gem 'jquery-rails', '~> 4.6'
gem 'mini_magick', '~> 4.12'
gem 'simple_form', '~> 5.3'
gem 'react-rails', '~> 2.7'         # keep if you actually use React views
gem 'pwa', '~> 4.0.4'               # keep if used

# JS/CSS bundling + assets (Rails 8 defaults)
gem 'jsbundling-rails'
gem 'cssbundling-rails', '~> 1.4'
gem 'propshaft'

# Platform quirks
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'rack', '>= 2.0.8'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '>= 3.39'
  gem 'factory_bot_rails', '~> 6.4'
  gem 'rspec-rails', '~> 6.1'
end

group :development do
  # Bullet is not yet AR 8-compatible; load it manually in dev.rb with a begin/rescue.
  gem 'bullet', '~> 6.1', require: false
  gem 'listen', '~> 3.8'
  gem 'spring', '~> 4.1'            # optional; you can remove Spring entirely
  gem 'spring-watcher-listen', '~> 2.1'
  gem 'selenium-webdriver', '~> 4.21'
  gem 'web-console', '>= 4.2'
end

# NOTE:
# - Removed: sass-rails (Sprockets-era)
# - Webpacker is gone; use jsbundling-rails + cssbundling-rails.
# - Consider replacing turbolinks with turbo-rails later if desired.
