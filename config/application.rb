require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# TODO：module名前をサービス名に変更する（期日：サービス名が決定したあと）
module Hello
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # MEMO：自動読み込み（参照：https://railsguides.jp/autoloading_and_reloading_constants.html）
    config.autoload_lib(ignore: %w[assets tasks])

    # Log to STDOUT because Docker expects all processes to log here. You could
    # then collect logs using journald, syslog or forward them somewhere else.
    config.logger = ActiveSupport::Logger.new($stdout)
                                         .tap  { |logger| logger.formatter = ::Logger::Formatter.new }
                                         .then { |logger| ActiveSupport::TaggedLogging.new(logger) }

    
    # MEMO: Redis 設定
    # Set Redis as the back-end for the cache.
    config.cache_store = :redis_cache_store, {
      url: ENV.fetch('REDIS_URL') { 'redis://redis:6379/1' },
      namespace: 'cache'
    }

    # MEMO: Sidekiq 設定
    # Set Sidekiq as the back-end for Active Job.
    config.active_job.queue_adapter = :sidekiq

    # TODO：aciton cable 設定 (利用しないので削除してOK)
    # Mount Action Cable outside the main process or domain.
    config.action_cable.mount_path = nil
    config.action_cable.url = ENV.fetch('ACTION_CABLE_FRONTEND_URL') { 'ws://localhost:28080' }

    # TODO：aciton cable 設定 (利用しないので削除してOK)
    # Only allow connections to Action Cable from these domains.
    origins = ENV.fetch('ACTION_CABLE_ALLOWED_REQUEST_ORIGINS') { "http:\/\/localhost*" }.split(',')
    origins.map! { |url| /#{url}/ }
    config.action_cable.allowed_request_origins = origins

    # MEMO:Rails Generators のコマンド制御
    config.generators do |g|
      g.assets false # assets（CSS, JavaScript ファイル）の作成をスキップ
      g.skip_routes true # config/routes.rb へのルート追加をスキップ
      g.test_framework false # テストの作成をスキップ
    end

    config.time_zone = 'Tokyo' # タイムゾーン 日本時間

    config.i18n.default_locale = :ja # 日本語設定

    # MEMO：デプロイするサービス（Render）のホストを追加する
    config.hosts << 'tentsauna.onrender.com'
  end
end
