class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :set_product]

  def index
    @products = Product.all
  end

  def show
  end

  def add_to_cart
    redirect_to :back
    flash[:notice] = "测试加入购物车"
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end
end
