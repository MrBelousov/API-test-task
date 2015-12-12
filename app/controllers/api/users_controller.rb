module Api
  class UsersController < BaseController
    # User authentication by api key
    before_action :restrict_access, except: [:index, :show]

    # Checking permissions for actions
    load_and_authorize_resource
    skip_authorize_resource only: [:index, :show, :create]

    # User authentications by email and token
    # before_filter :authenticate_user!, except: [:show]

    # GET /users
    def index
      @users = User.all
      render(
        json: ActiveModel::ArraySerializer.new(
          @users,
          each_serializer: UserSerializer
        )
      )
    end

    # GET /users/1
    def show
      @user = User.find(params[:id])
      render json: UserSerializer.new(@user).to_json
    end

    # POST /users
    def create
      @user = User.new(user_params)
      if @user.save
        render json: UserSerializer.new(@user).to_json
      else
        render json: { errors: @user.errors, error_code: 402 }, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        render json: UserSerializer.new(@user).to_json
      else
        render json: { errors: @user.errors, error_code: 402 }, status: :unprocessable_entity
      end
    end

    # DELETE /users/1
    def destroy
      @user = User.find(params[:id])
      @user.destroy
    end

    private

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:first_name, :email, :password)
    end
  end
end
