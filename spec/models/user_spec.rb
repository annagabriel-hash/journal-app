require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {User.new(username: 'johndoe', firstname: 'John', lastname: 'Doe', password: 'password')}

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
end