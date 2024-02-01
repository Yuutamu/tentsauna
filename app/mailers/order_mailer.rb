  # 以下、開発メモ。実装後に削除必要。
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #   en.order_mailer.complete.subject
  # to:（送信先） subject:（件名）
  # メールの本文は、app/views/order_mailer/completion.html.erb に記述
  # 検証中：件名を日本語にて送信

class OrderMailer < ApplicationMailer
  def complete(args)
    email = args[:email]
    @url  = 'http://localhost:8000/orders'
    mail(to: email, subject: 'ご注文ありがとうございます。')
  end
end
