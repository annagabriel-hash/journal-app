require 'rails_helper'

RSpec.describe "ViewCategories", type: :system, js: true do
  let(:user) {User.create(username: 'janedoe', firstname: 'Jane', lastname: 'Doe', password: 'password', password_confirmation: 'password')}
  let!(:category) { Category.create(name: 'Travel', user: user) }

  def login(user)
    visit root_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Log In'
  end
  
  describe 'index view' do
    it 'display all categories' do
      visit categories_path
      within 'tbody' do
        expect(page).to have_selector('tr', count: 1)
      end
    end
    it "loads the edit view when the 'Edit' button is clicked" do
      visit categories_path
      within 'tbody' do
        find_link('Edit').click
      end 
      expect(page).to have_current_path(edit_category_path(category))
      expect(find_field('Name').value).to eq category.name
    end
    it "loads the show view when the 'Show' button is clicked" do
      visit categories_path
      within 'tbody' do
        find_link('Show').click
      end
      expect(page).to have_current_path(category_path(category))
      expect(page).to have_content(category.name.capitalize)
    end
    it "destroys category when the 'delete' button is clicked" do
      visit categories_path
      expect do
        accept_alert 'Are you sure?' do
          within 'tbody' do
            click_link('Delete')
          end
        end
        # Redirect back to the index view after record is destroyed.
        # Must be inside the #expect block to ensure the DB operation is
        # finished before trying to count records.
        expect(page).to have_current_path(categories_path)
      end.to change(Category, :count).by(-1)
      # Page should show success message
      expect(page).to have_content('Category was deleted successfully')
    end
  end
end
