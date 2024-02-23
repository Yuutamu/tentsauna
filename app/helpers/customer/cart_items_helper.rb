# MEMO：ビューの中で、カート内商品の quantity の合計値を算出するため、ヘルパーメソッドを定義。

module Customer::CartItemsHelper
  def total_quantity(cart_items)
    cart_items.sum(:quantity)
  end
end
