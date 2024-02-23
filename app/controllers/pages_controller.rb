# TopPage 商品表示処理

class PagesController < ApplicationController
  def home
    @products = products_in_descending
  end

  private

  # MEMO:UI観点から、おすすめ商品を価格の高い３商品を表示
  def products_in_descending
    Product.price_high_to_low.limit(3)
  end
end
