class StaticPagesController < ApplicationController
  def index
  end

  def show
    @page = StaticPage.find_by(identifier: params[:identifier])
    render :show
  end
end
