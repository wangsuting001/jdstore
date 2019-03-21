class Admin::OrdersController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required

  def index
    # TODO 待优化
    @orders = Order.order("id DESC")
  end

  def show
    @order = Order.find(params[:id])
    @product_lists = @order.product_lists
  end

  def ship
    # TODO 优化@ordertouch app/views/admin/orders/_state_option.html.erb
    @order = Order.find(params[:id])
    @order.ship!
    redirect_to :back
  end

  def shipped
    @order = Order.find(params[:id])
    @order.deliver!
    redirect_to :back
  end

  def cancel
    @order = Order.find(params[:id])
    @order.cancel_order!
    redirect_to :back
  end

  def return
    @order = Order.find(params[:id])
    @order.return_good!
    redirect_to :back
  end
end
