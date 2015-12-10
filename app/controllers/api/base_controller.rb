module Api
  class BaseController < ApplicationController
    protect_from_forgery with: :null_session

    before_action :destroy_session

    def destroy_session
      request.session_options[:skip] = true
    end

    def authenticate_user!
      token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

      user_email = options.blank?? nil : options[:email]
      user = user_email && User.find_by(email: user_email)

      if user && ActiveSupport::SecurityUtils.secure_compare(user.token, token)
        @current_user = user

        # Limit session to 2 hours
        if session[:logged_in]
          reset_session if session[:last_seen] < 2.hours.ago
          session[:last_seen] = Time.now
        end
      else
        render json: {message: 'Unauthorized!'}, status: 401
      end
    end

  end
end