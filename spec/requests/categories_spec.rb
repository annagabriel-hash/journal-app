require 'rails_helper'

RSpec.describe 'CategoriesController', type: :request do
  let(:category) { Category.new(name: 'sports') }

  describe "GET /index" do
    it 'returns index page' do
      get categories_path
      expect(response).to render_template(:index)
      expect(response).to have_http_status(:success)
    end
  end
  describe "GET /show" do
    it 'returns show page' do
      category.save
      get category_path(category.id)
      expect(response).to render_template(:show)
      expect(response).to have_http_status(:success)
    end
  end
  describe "GET /new" do
    it 'returns new page' do
      get new_category_path
      expect(response).to render_template(:new)
      expect(response).to have_http_status(:success)
    end
  end
  describe "GET /edit" do
    it 'returns edit page' do
      category.save
      get edit_category_path(category)
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:success)
    end
  end
  describe "POST /create" do
    it 'creates new category' do
      expect do
        post categories_path, params: { category: { name: category.name} }
        expect(response).to redirect_to(assigns(:category))
        follow_redirect!
        expect(response).to render_template(:show)
      end.to change(Category, :count).by(1)
    end
    it 'renders new for new category with invalid inputs' do
      expect do
        post categories_path, params: { category: { name: ''} }
        expect(response).to render_template(:new)
      end.to_not change(Category, :count)
    end
  end
  describe "PATCH /update"
    it 'updates existing category' do
      category.save
      expect do
        patch category_path(category.id), params: { category: { name: 'travel' } }
        # Assigns relates to the instance variables created within a controller action 
        # e.g., :category => @category
        expect(response).to redirect_to(assigns(:category))
        follow_redirect!
        expect(response).to render_template(:show)
      end.to_not change(Category, :count)
      expect(Category.last.name).to eq('travel')
    end
    
    it 'renders new for invalid inputs' do
      category.save
      expect do
        patch category_path(category), params: { category: { name: ' ' } }
        expect(response).to render_template(:edit)
      end.to_not change(Category, :count)
      # No changes to the data
      expect(Category.last.name).to eq(category.name)
    end
  describe "DELETE /destroy" do
    it 'destroy existing category' do
      category.save
      expect do
        delete category_path(category.id)
        expect(response).to redirect_to(categories_path)
      end.to change(Category, :count).by(-1)
    end
  end
end