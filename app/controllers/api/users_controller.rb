module Api
  class UsersController < BaseController

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
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        render json: UserSerializer.new(@user).to_json
      else
        render json: @user.errors, status: :unprocessable_entity
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
