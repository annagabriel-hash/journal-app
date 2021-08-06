class CategoriesController < ApplicationController
  # before_action :set_category, only: %i[show edit update destroy]
  before_action :get_user
  before_action :set_category, only: %i[show edit update destroy]
  before_action :require_login

  def index
    @categories = @user.categories
  end

  def show
  end

  def new
    @category = @user.categories.build
  end
  
  def edit
  end

  def create
    @category = @user.categories.build(category_params)
    if @category.save
      redirect_to user_category_path(@user, @category), notice: 'Category was created successfully'
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to user_category_path(@user, @category), notice: 'Category was updated successfully'
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to user_categories_path, notice: 'Category was deleted successfully'
  end

  private

  def get_user 
    @user = User.find(params[:user_id])
  end
  
  def set_category
    @category = @user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :user_id)  
  end
end