require 'rails_helper'

RSpec.describe "EditCategories", type: :system, js: true do
  let(:user) {User.create(username: 'janedoe', firstname: 'Jane', lastname: 'Doe', password: 'password', password_confirmation: 'password')}
  let(:category) { Category.create(name: 'Sports', user: user) }
  
  def login(user)
    visit root_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Log In'
  end

  before do
    driven_by :selenium, using: :chrome
    login(user)
  end

  context 'with valid inputs' do
    it 'displays and updates category details' do
      visit edit_user_category_path(user, category)
      expect do
        # Form should be prefilled
        expect(find_field('Name').value).to eq 'sports'
        # Fill in form
        within 'form' do
          fill_in 'Name', with: 'Chores'
          click_button 'Update Category'
        end
        # Page should show success message
        expect(page).to have_content('Category was updated successfully')

        # Page should display new category
        expect(page).to have_current_path(user_category_path(user, Category.last))
        expect(page).to have_content('Chores')
      end.to_not change(Category, :count)
      expect(Category.last.name).to eq('chores')
    end
  end
  context ' with invalid inputs' do
    it 'displays error message and renders edit view' do
      visit edit_user_category_path(user, category)
      expect do
        # Fill in form
        within 'form' do
          fill_in 'Name', with: ' '
          click_button 'Update Category'
        end
        # Page should show error message
        expect(page).to have_content("Name can't be blank")

        # Page should render edit view
        expect(page).to have_content('Edit category')
      end.to_not change(Category, :count)
      expect(Category.last.name).to eq('sports')
    end
  end
end
