require 'rails_helper'

RSpec.describe "CreateCategories", type: :system, js: true do
  let(:user) {User.create(username: 'janedoe', firstname: 'Jane', lastname: 'Doe', password: 'password', password_confirmation: 'password')}
  
  def login(user)
    visit root_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Log In'
  end

  before do
    driven_by :selenium, using: :chrome
    login(user)
    visit new_user_category_path(user)
  end

  context 'valid inputs' do
    it 'saves and displays new category' do
      # Fill in form
      expect do
        within 'form' do
          fill_in 'Name', with: 'Sports'
          click_on 'Create Category'
        end
        # Page should show success message
        expect(page).to have_content('Category was created successfully')

        # Page redirected to show view
        expect(page).to have_content('Sports')

      end.to change(Category, :count).by(1)
      expect(Category.last.name).to eq('sports')
    end
  end
  context 'invalid inputs' do
    it 'renders new view and displays error' do
      # Fill in form
      expect do
        within 'form' do
          click_on 'Create Category'
        end

        # Page redirected to show view
        expect(page).to have_content("Name can't be blank")

      end.to_not change(Category, :count)

    end
  end
end
