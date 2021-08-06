module Helpers
  module Authentication
    def sign_in_as(user)
      post login_path, params: { session: { username: user, password: 'password'} }
    end
  end
end