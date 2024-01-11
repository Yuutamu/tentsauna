class Customer::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_cart_item, only: %i[increase decrease destroy]

  def index
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.line_total }
  end

  def create
    increase_or_create(params[:cart_item][:product_id])
    redirect_to cart_items_path, notice: 'カートに商品を追加しました。'
  end

  # メモ：通常CRUD処理以外のメソッド名。一般的な動詞にした
  def increase
    @cart_item.increment!(:quantity, 1)
    redirect_to request.referer, notice: 'カート商品を更新しました。'
  end

  # メモ：通常CRUD処理以外のメソッド名。一般的な動詞にした
  def decrease
    decrease_or_destroy(@cart_item)
    redirect_to request.referer, notice: 'カート商品を更新しました。'
  end

  def destroy
    @cart_item.destroy
    redirect_to request.referer, notice: 'カート商品を削除しました。'
  end

  private

  def set_cart_item
    @cart_item = current_customer.cart_items.find(params[:id])
  end

  # メモ：増加の際はincrement | 新規作成時はcreate
  def increase_or_create(product_id)
    cart_item = current_customer.cart_items.find_by(product_id:)
    if cart_item
      cart_item.increment!(:quantity, 1)
    else
      current_customer.cart_items.build(product_id:).save # メモ：createにしないことでdebugしやすくさせる
    end
  end

  # メモ：減少の際はdecrement | カート削除時はdestroy
  def decrease_or_destroy(cart_item)
    if cart_item.quantity > 1
      cart_item.decrement!(:quantity, 1)
    else
      cart_item.destroy
    end
  end
end
