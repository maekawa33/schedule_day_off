source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.3"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"

#CSS Bundler
gem 'cssbundling-rails'

# Use Sass to process CSS
gem "sassc-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# 日本語化
gem 'rails-i18n'
gem 'enum_help'

# ログイン機能
gem 'sorcery'

# 検索機能
gem 'ransack'

# ページネーション
gem 'kaminari'

# 画像アップロード
gem 'carrierwave'
gem 'mini_magick'

# メタタグの設定
gem 'meta-tags'

# 管理画面
gem 'rails_admin', '~> 3.0'

# 権限管理
gem 'cancancan'

# 環境別定数管理
gem 'config'

# 環境変数
gem 'dotenv-rails'

# Googleログイン
gem 'googleauth'

group :production do
  # Amazon S3を使用するためのパッケージ
  gem 'aws-sdk-s3', require: false
end

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  # デバックツール
  gem "debug", platforms: %i[ mri mingw x64_mingw ]

  # テスティングフレームワーク
  gem 'rspec-rails'

  # テスト用データ作成
  gem 'factory_bot_rails'
end

group :test do
  # ブラウザ操作シミュレーション
  gem 'capybara'

  # webドライバの自動インストール、アップデート
  gem 'webdrivers'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # Lint
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec'
  gem 'erb_lint', require: false

  # N+1問題検出
  gem 'bullet'

  # エラー画面の整形
  gem 'better_errors'

  # ブラウザ上のエラー画面でirb
  gem 'binding_of_caller'

  # ダミーデータの作成
  gem 'faker'

  # コード補完、ドキュメント提供
  gem 'solargraph'

  # 開発環境でのメール受信
  gem 'letter_opener_web', '~> 1.0'
end