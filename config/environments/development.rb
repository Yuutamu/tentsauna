require "active_support/core_ext/integer/time"

# MEMO：開発環境では、アプリケーションのコードは変更されるたびに再ロードされる。
# MEMO：これにより応答時間は遅くなるが、コードを変更するときに Web サーバーを再起動する必要がないため、開発には最適なので採用。
Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.enable_reloading = true

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing
  config.server_timing = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # MEMO:アップロードされたファイルをローカル ファイル システムに保存
  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # MEMO：ActionMailer設定 （メール送信ができていないことを無視する）
  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # アプリケーションのホスト情報を設定
  config.action_mailer.default_url_options = { host: 'localhost', port: 8000 }

  # メールの送信方式を SMTP（Simple Mail Transfer Protocol）に設定
  config.action_mailer.delivery_method = :smtp

  # SMTP設定
  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    domain: 'gmail.com',
    port: 587,
    user_name: Rails.application.credentials.dig(:gmail, :email),
    password: Rails.application.credentials.dig(:gmail, :app_password),
    authentication: :login
  }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Highlight code that enqueued background job in logs.
  config.active_job.verbose_enqueue_logs = true

  # Disable digesting assets with an md5 tag.
  config.assets.digest = false

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # MEMO：i18機能の翻訳が見つからなった場合にエラーを発生させる（ja.ymlのログをきちんとカバーする必要がある）
  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # MEMO:Action Cable 設定
  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true

  # Raise error when a before_action's only/except options reference missing actions.
  config.action_controller.raise_on_missing_callback_actions = true

  # Comma separated list of IP addresses / CIDRs that can use the web-console
  # which is invoked with `console` in a controller or <% console %> in a view.
  #
  # Docker supports a bunch of ranges so let's just support everything. This
  # isn't insecure due to only running in development.
  config.web_console.allowed_ips = ["0.0.0.0/0"]
end
