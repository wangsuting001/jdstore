class Admin::OrdersController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required

  def index
    # TODO 待优化
    @orders = Order.order("id DESC")
  end
end
