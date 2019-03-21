class Account::OrdersController < ApplicationController

  def index
    # TODO 待优化
    @orders = current_user.orders.order("id DESC")
  end
end
