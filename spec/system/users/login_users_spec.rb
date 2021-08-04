require 'rails_helper'

RSpec.describe "LoginUsers", type: :system do
  let!(:user) {User.create(username: 'johndoe', firstname: 'John', lastname: 'Doe', password: 'password', password_confirmation: 'password')}
  before do
    driven_by(:rack_test)
  end

  context 'with valid inputs' do
    it 'stores user details and display user profile' do
      visit login_path
      # Fill in login details
      fill_in 'Username', with: user.username
      fill_in 'Password', with: 'password'
      click_on 'Log In'
      # Test data
      expect(session[:user_id]).to eq(user.id)
      # Test page
      expect(page).to have_current_path(user_path(user))
      expect(page).to have_content('Login successful')
      expect(page).to have_content("Welcome #{user.firstname.capitalize}!")
    end
  end
end
