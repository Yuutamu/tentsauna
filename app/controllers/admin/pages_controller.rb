class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def home
    @orders, @selected = get_orders(params)
    today_orders = Order.created_today # created_today
    @today_total_orders = total_orders(today_orders)
    @today_total_sales = total_sales(today_orders)
  end

  private

  def get_orders(params)
    return [Order.latest, 'all'] if !params[:status].present? || !Order.statuses.keys.to_a.include?(params[:status])

    get_by_enum_value(params[:status])
  end

  def get_by_enum_value(status)
    case status
    when 'waiting_payment'
      [Order.latest.waiting_payment, '入金待ち']
    when 'confirm_payment'
      [Order.latest.confirm_payment, '入金済み']
    when 'shipped'
      [Order.latest.shipped, '配送会社依頼済み']
    when 'out_of_delivery'
      [Order.latest.out_of_delivery, '配送中']
    when 'deliverd'
      [Order.latest.deliverd, '配送済み']
    end
  end

  def total_orders(orders)
    orders.count
  end

  def total_sales
    orders.sum(:billing_amount)
  end
end
