# MEMO: VIエディタよりcredentialsに登録した内容をdigメソッドで参照する（参照：https://spirits.appirits.com/doruby/9473/）
Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
# MEMO: api_vesion 最新確認（公式：https://stripe.com/docs/api/versioning?lang=ruby）
Stripe.api_version = '2023-10-16'
