class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_customer, only: %i[show update]

  def index
    # 1+N問題の解消(子テーブル：Order を事前読み込み)
    @customers = Customer.preload(:orders).latest
  end

  def show; end

  def update
    @customer.update(customer_params)
    redirect_to request.referer, notice: '顧客ステータスが更新されました。'
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:status)
  end
end
