require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  let!(:user) {User.create(username: 'johndoe', firstname: 'John', lastname: 'Doe', password: 'password', password_confirmation: 'password')}

  describe "POST /create" do
    context 'with valid inputes' do
      it 'stores username to session' do
        post login_path, params: { session: { username: user.username, password: 'password'} }
        expect(session[:user_id]).to eq(user.id)
      end
    end
    context 'with inexisting username' do
      it 'does not store username to session and renders new template' do
        post login_path, params: { session: { username: 'janedoe', password: 'password'} }
        expect(session[:user_id]).to be_nil
        expect(response).to render_template(:new)
      end
    end
    context 'with incorrect password  and renders new template' do
      it 'does not store username to session and renders new template' do
        post login_path, params: { session: { username: user.username, password: 'notmatch'} }
        expect(session[:user_id]).to be_nil
        expect(response).to render_template(:new)
      end
    end
  end
end