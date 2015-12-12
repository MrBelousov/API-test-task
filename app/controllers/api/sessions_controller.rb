module Api
  class SessionsController < BaseController
    def create
      user = User.find_by(email: create_params[:email])
      if user && user.authenticate(create_params[:password])
        self.current_user = user

        # Session expiring after 2 hours
        session[:expires_at] = Time.current + 2.hours
        render(
          json: SessionSerializer.new(user, root: false).to_json,
          status: 201
        )
      else
        render json: { message: 'Access allowed only for registered users.', error_code: 401 }, status: 401
      end
    end

    private

    def create_params
      params.require(:user).permit(:email, :password)
    end
  end
end
