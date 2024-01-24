# frozen_string_literal: true

class Customer::SessionsController < Devise::SessionsController
  before_action :reject_invalid_customer, only: [:create]

  protected

  def reject_invalid_customer
    customer = Customer.find_by(email: params[:customer][:email])
    return unless customer # 早期リターン（customer か否か）

    # メモ：active_for_authentication? devise.gem デフォルトのものを上書き済み
    return if customer.valid_password?(params[:customer][:password]) && customer.active_for_authentication?

    alert_message = if customer.status == 'withdrawn'
                      'すでに退会済みです。'
                    else
                      'あなたのアカウントは利用停止中です。'
                    end
    redirect_to request.referer, alert: alert_message
  end
end
