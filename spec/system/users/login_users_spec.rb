require 'rails_helper'

RSpec.describe "LoginUsers", type: :system do
  let!(:user) {User.create(username: 'johndoe', firstname: 'John', lastname: 'Doe', password: 'password', password_confirmation: 'password')}
  before do
    driven_by(:rack_test)
  end

  context 'with valid inputs' do
    it 'stores user details and display user profile' do
      visit root_path
      expect(page).to have_link('Sign up')
      # Fill in login details
      fill_in 'Username', with: user.username
      fill_in 'Password', with: 'password'
      click_on 'Log In'
      # Test page
      expect(page).to have_current_path(user_path(user))
      expect(page).to have_content('Login successful')
      expect(page).to have_content("Welcome #{user.firstname.capitalize}!")
    end
  end
  context 'with inexisting username' do
    it 'displays error message' do
      visit login_path
      # Fill in login details
      fill_in 'Username', with: 'janedoe'
      fill_in 'Password', with: 'password'
      click_on 'Log In'
      # Test page
      expect(page).to have_content('Invalid username or password')
    end
  end
  context 'with incorrect password' do
    it 'displays error message' do
      visit login_path
      # Fill in login details
      fill_in 'Username', with: user.username
      fill_in 'Password', with: 'newpassword'
      click_on 'Log In'
      # Test page
      expect(page).to have_content('Invalid username or password')
    end
  end
end
