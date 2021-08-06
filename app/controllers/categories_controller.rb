class CategoriesController < ApplicationController
  # before_action :set_category, only: %i[show edit update destroy]
  before_action :get_user
  before_action :set_category, only: :show
  before_action :require_login

  def index
    @categories = @user.categories
  end

  def show
  end

  def new
    @category = Category.new
  end
  
  def edit
  end

  def create
    @category = Category.new(category_params)
    @category.user = current_user
    if @category.save
      redirect_to @category, notice: 'Category was created successfully'
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Category was updated successfully'
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, notice: 'Category was deleted successfully'
  end

  private

  def get_user 
    @user = User.find(params[:user_id])
  end
  
  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)  
  end
end