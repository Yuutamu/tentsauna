class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # customize validations of Devise.gem
  with_options presence: true do
    validates :name
    validates :status
  end

  # Customer Status
  enum status: {
    normal: 0,    # 通常
    withdrawn: 1, # 退会済み
    banned: 2     # アカウント停止（運営判断による）
  }

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  # メモ：オブジェクトのプロパティは、Stripe 側で指定されている
  def line_items_checkout
    cart_items.map do |cart_item|
      {
        quantity: cart_item.quantity,
        price_data: {
          currency: 'jpy',
          unit_amount: cart_item.product.price,
          product_data: {
            name: cart_item.product.name,
            metadata: {
              product_id: cart_item.product_id
            }
          }
        }
      }
    end
  end
end
