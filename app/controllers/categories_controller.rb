class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end
  
  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category, notice: 'Category was created successfully'
    else
      render :new
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to @category, notice: 'Category was updated successfully'
    else
      render :edit
    end
  end
  private

  def category_params
    params.require(:category).permit(:name)  
  end
end