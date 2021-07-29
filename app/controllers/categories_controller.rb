class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category, notice: 'Category was created successfully'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)  
  end
end