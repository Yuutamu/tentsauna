class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_order

  def show; end

  def update
    @order.update(order_params) # MEMO:ストロングパラメータ
    redirect_to admin_order_path(@order), notice: '注文ステータスを更新更新しました。'
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status) # MEMO:許可するパラメータはstatus のみ
  end
end
