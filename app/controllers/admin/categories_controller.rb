class Admin::CategoriesController < ApplicationController
  
  before_filter :authorize

  def index
    @categories = Category.all.order(id: :asc)
  end

  def edit
  end

  def update
    @category.update_attributes(category_params)
    redirect_to action: "index"
  end

  def destroy
    @category.delete
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

end