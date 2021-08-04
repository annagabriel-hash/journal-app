require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  let!(:user) {User.create(username: 'johndoe', firstname: 'John', lastname: 'Doe', password: 'password', password_confirmation: 'password')}

  describe "POST /create" do
    it 'stores username to session' do
      post login_path, params: { session: { username: user.username, password: 'password'} }
      expect(session[:user_id]).to eq(user.id)
    end
  end
end