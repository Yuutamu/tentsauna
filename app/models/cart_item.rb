class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :product

  # カート内商品の合計金額（縦列の合計金額）
  def line_total
    product.price * quantity
  end
end
