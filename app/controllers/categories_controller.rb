class CategoriesController < ApplicationController

  def index
    @category = Category.first
  end

  def show
    @category = Category.find_by_id(params[:id])
  end
  
end
