# to:（送信先） subject:（件名）
# メールの本文は、app/views/order_mailer/completion.html.erb に記述

class OrderMailer < ApplicationMailer
  def complete(args)
    email = args[:email]
    @url  = 'http://localhost:8000/orders'
    mail(to: email, subject: 'Your order has been completed')
  end
end
