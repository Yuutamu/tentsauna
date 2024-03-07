# Stripe 特有の書き方が多いのでリファレンス参照（公式Doc:https://stripe.com/docs/api/checkout/sessions/object）
class Customer::CheckoutsController < ApplicationController
  before_action :authenticate_customer!

  def create
    line_items = current_customer.line_items_checkout # MEMO: line_items == "顧客が購入した品目"
    session = create_session(line_items)

    redirect_to session.url, allow_other_host: true # MEMO: 現在のホストとは異なるホストへのリダイレクトを許可する StripeCheckoutページ
  end

  private

  def create_session(line_items)
    Stripe::Checkout::Session.create(
      client_reference_id: current_customer.id, # MEMO: チェックアウトセッションを参照するためのユニークな文字列。 顧客IDとして利用
      customer_email: current_customer.email,
      mode: 'payment', # MEMO: CheckOut Session Mode (payment, setup, subscription がある)
      payment_method_types: ['card'], # MEMO: 支払い方法（クレカ決済のみにする方針）
      line_items:,

      # MEMO：配送希望日の入力欄
      # TODO: 注文ごとにdashbord確認するタスクを省くために、処理を実装したい（DB,controller）
      custom_fields: [
        {
          key: 'delivery_date',
          label: {
            type: 'custom',
            custom: '配送希望日 MM(月)/DD(日)'
          },
          optional: true,
          type: 'text'
        }
      ],

      shipping_address_collection: {
        allowed_countries: ['JP']
      },
      shipping_options: [
        {
          shipping_rate_data: {
            type: 'fixed_amount', # MEMO: 全商品の送料固定
            fixed_amount: {
              amount: 3000, # MEMO: 送料
              currency: 'jpy'
            },
            display_name: '往復配送料金 (返却時の配送料金は無料)'
          }
        }
      ],
      success_url: "#{root_url}orders/success", # MEMO: サンクスページ
      cancel_url: "#{root_url}cart_items" # MEMO:決済キャンセル時
    )
  end
end
