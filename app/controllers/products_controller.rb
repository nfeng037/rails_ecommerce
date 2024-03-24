class ProductsController < ApplicationController
  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @products = @category.products.page(params[:page]).per(12)
    elsif params[:name]
      @products = Product.where('name LIKE ?', "%#{params[:name]}%").page(params[:page]).per(12)
    elsif params[:active] == "true"
      @products = Product.where(active: true).page(params[:page]).per(12)
    else
      @products = Product.page(params[:page]).per(12)
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
