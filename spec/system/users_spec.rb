require 'rails_helper'

RSpec.describe "CreatingNewUsers", type: :system do
  before do
    driven_by(:rack_test)
  end

  context 'with valid inputs' do
    it 'saves and displays the new user' do
      visit signup_path
      # Fill in form
      expect do
        within 'form' do
          fill_in 'First Name', with: 'John'
          fill_in 'Last Name', with: 'Doe'
          fill_in 'Username', with: 'johndoe'
          fill_in 'Password', with: 'password'
          fill_in 'Confirm Password', with: 'password'
          click_on 'Create Account'
        end
        # Page should show success message
        expect(page).to have_content('Account was created successfully')

        # Test data
      end.to change(User, :count).by(1)
      user = User.where(username: 'johndoe')
      expect(user).to exist
      expect(user.first.firstname).to eq('John')
      expect(user.first.lastname).to eq('Doe')

      # Page redirected to show view
      expect(page).to have_current_path(user_path(User.last))
      expect(page).to have_content('Welcome John!')
    end
  end
  context 'with invalid inputs' do
    it 'raises and displays error' do
      visit signup_path
      # Fill in form
      expect do
        within 'form' do
          fill_in 'First Name', with: 'John'
          fill_in 'Last Name', with: 'Doe'
          fill_in 'Username', with: 'johndoe'
          fill_in 'Password', with: 'password'
          fill_in 'Confirm Password', with: 'newpassword'
          click_on 'Create Account'
        end

        expect(page).to have_content("Password confirmation doesn't match Password")
      end.to_not change(User, :count)
      expect{ User.find_by!(username: 'johndoe') }.to raise_error(ActiveRecord::RecordNotFound)

      # Page should render signup page
      expect(page).to have_content('Sign Up')
    end
  end
end
