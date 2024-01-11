class Customer::ProductsController < ApplicationController
  def index
    @products, @sort = get_products(params)
  end

  def show
    @product = Product.find(params[:id])
    @cart_item = CartItem.new
  end

  private

  def get_products(params)
    return Product.all, 'default' unless params[:latest] || params[:price_high_to_low] || params[:price_low_to_high]

    # メモ：Product.where(order(created_at: :desc))
    return Product.latest, 'latest' if params[:latest]

    # メモ：Product.where(order(price: :desc))
    return Product.price_high_to_low, 'price_high_to_low' if params[:price_high_to_low]

    # メモ：Product.where(order(price: :asc))
    [Product.price_low_to_high, 'price_low_to_high'] if params[:price_low_to_high]
  end
end
