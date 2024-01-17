# Stripe 特有の書き方が多い（公式Doc:https://stripe.com/docs/api/checkout/sessions/object）
class Customer::CheckoutsController < ApplicationController
  before_action :authenticate_customer!

  def create
    # line_items == "顧客が購入した品目"
    line_items = current_customer.line_items_checkout
    session = create_session(line_items)

    # 現在のホストとは異なるホストへのリダイレクトを許可する StripeCheckoutページ
    redirect_to session.url, allow_other_host: true
  end

  private

  def create_session(line_items)
    Stripe::Checkout::Session.create(
      client_reference_id: current_customer.id, # チェックアウトセッションを参照するためのユニークな文字列。 顧客IDとして利用
      customer_email: current_customer.email,
      mode: 'payment', # CheckOut Session Mode (payment, setup, subscription がある)
      payment_method_types: ['card'], # クレカ支払いのみOK
      line_items:,
      shipping_address_collection: {
        allowed_countries: ['JP']
      },
      shipping_options: [
        {
          shipping_rate_data: {
            type: 'fixed_amount', # 全商品の送料固定
            fixed_amount: {
              amount: 3000, # 送料
              currency: 'jpy'
            },
            display_name: 'Single rate'
          }
        }
      ],
      success_url: "#{root_url}orders/success", # サンクスページ
      cancel_url: "#{root_url}cart_items" # 決済キャンセル時
    )
  end
end
