class Admin::OrdersController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required
  before_action :load_order, only: [:show, :ship, :shipped, :cancel, :return]

  def index
    @orders = Order.recent
  end

  def show
    @product_lists = @order.product_lists
  end

  def ship
    @order.ship!
    OrderMailer.notify_ship(@order).deliver!
    redirect_back(fallback_location: admin_orders_path)
  end

  def shipped
    @order.deliver!
    redirect_back(fallback_location: admin_orders_path)
  end

  def cancel
    @order.cancel_order!
    OrderMailer.notify_cancel(@order).deliver!
    redirect_back(fallback_location: admin_orders_path)
  end

  def return
    @order.return_good!
    redirect_back(fallback_location: admin_orders_path)
  end

  private
  def load_order
    @order = Order.find(params[:id])
  end
end
