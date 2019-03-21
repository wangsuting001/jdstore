class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :set_product]

  def index
    @products = Product.all
  end

  def show
  end

  def add_to_cart
    current_cart.add_product_to_cart(@product)
    flash[:notice] = "成功加入购物车"
    redirect_to :back
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end
end
