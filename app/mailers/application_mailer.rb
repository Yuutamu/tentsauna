# メール送信時のアドレス指定
class ApplicationMailer < ActionMailer::Base
  default from: 'tentsauna.product@gmail.com'
  layout 'mailer'
end
