require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {User.new(username: 'johndoe', firstname: 'John', lastname: 'Doe')}

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end
end