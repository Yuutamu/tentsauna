Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
# api_vesion 最新確認（公式：https://stripe.com/docs/api/versioning?lang=ruby）
Stripe.api_version = '2023-10-16'
