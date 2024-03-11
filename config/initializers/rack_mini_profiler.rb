# MEMO: dev環境のみに反映
Rack::MiniProfiler.config.enable_hotwire_turbo_drive_support = true if Rails.env.development?
