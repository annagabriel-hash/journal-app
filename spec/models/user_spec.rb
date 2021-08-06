require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {User.create(username: 'janedoe', firstname: 'Jane', lastname: 'Doe', password: 'password', password_confirmation: 'password')}

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without username' do
    user.username = ' '
    expect(user).to_not be_valid
  end

  it 'is not valid without password' do
    user.password = '  '
    expect(user).to_not be_valid
  end

  it 'is not valid without firstname' do
    user.firstname = ' '
    expect(user).to_not be_valid
  end

  it 'has unique username' do
    duplicate_user = user.dup
    user.save
    expect(duplicate_user).to_not be_valid
  end

  it 'has a secure password' do
    user.save
    expect(user.password_digest).to_not eq('password')
  end

  context 'is deleted' do
    it 'associated categories are deleted' do
      user.save
      user.categories.create(name: 'coding')
      expect { user.destroy }.to change(Category, :count).by(-1)
    end
  end
end