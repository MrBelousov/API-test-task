module Api
  class BaseController < ApplicationController
    # protect_from_forgery with: :null_session

    # before_action :destroy_session

    # def destroy_session
    #  request.session_options[:skip] = true
    # end

    private

    def authenticate_user!
      token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

      user_email = options.blank? ? nil : options[:email]
      user = user_email && User.find_by(email: user_email)

      if user && ActiveSupport::SecurityUtils.secure_compare(user.token, token)
        @current_user = user

        # Sign out after 2 hours
        sign_out if session[:expires_at] < Time.current
      else
        render json: { message: 'Unauthorized!', error_code: 401 }, status: 401
      end
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user
  end
end
