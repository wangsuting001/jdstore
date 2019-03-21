class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :add_to_cart]

  def index
    @products = Product.all
  end

  def show
  end

  def add_to_cart
    current_cart.add_product_to_cart(@product)
    flash[:notice] = "成功加入购物车"
    redirect_back(fallback_location: root_path)
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end
end
