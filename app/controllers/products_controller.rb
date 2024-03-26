class ProductsController < ApplicationController
  def index
    scope = Product.all

    # Filter the product by category
    if params[:category_id].present?
      scope = scope.where(category_id: params[:category_id])
    end

    # Search through the available products using a keyword
    if params[:search].present?
      keyword = "%#{params[:search]}%"
      scope = scope.where('name LIKE ? OR description LIKE ?', keyword, keyword)
    end

    # Display only products that are on sale
    if params[:active] == "true"
      scope = scope.where(active:true)
    # Display only products that are "new"
    elsif params[:new] == "true"
      scope = scope.where('created_at >= ?', 3.days.ago)
    # Display only procts that have been "recently updated" without "new"
    elsif params[:update] == "true"
      scope = scope.where('updated_at >= ?', 3.days.ago).where.not("created_at >= ?", 3.days.ago)
    end

    # Apply pagination
    @products = scope.page(params[:page]).per(12)
  end

  def show
    @product = Product.find(params[:id])
    @recommend_products = Product.order(Arel.sql('RANDOM()')).limit(4)
  end
end
