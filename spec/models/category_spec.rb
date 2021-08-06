require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) {User.create(username: 'janedoe', firstname: 'Jane', lastname: 'Doe', password: 'password', password_confirmation: 'password')}
  let(:category) { Category.new(name: 'Coding', user: user) }

  it "is valid with valid attributes" do
    expect(category).to be_valid
  end

  it "is not valid without a name" do
    category.name = ''
    expect(category).to_not be_valid
  end

  it "is unique" do
    category.save
    new_category = Category.new(name: 'coding')
    expect(new_category).to_not be_valid
  end

  it "is saved in lowercase" do
    mixed_case_name = 'coDinG'
    category.name = mixed_case_name
    category.save
    expect(category.reload.name).to eq mixed_case_name.downcase
  end

end