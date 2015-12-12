module Api
  class CommentsController < BaseController
    # User authentication by api key
    before_action :restrict_access, only: :update

    # Checking permissions for actions
    load_and_authorize_resource
    skip_authorize_resource only: [:index, :show, :create]

    # User authentication by token and email
    # before_filter :authenticate_user!, only: [:update, :destroy]

    # GET /comments
    def index
      @news = News.find(params[:news_id])
      @comments = @news.comments
      render(
        json: ActiveModel::ArraySerializer.new(
          @comments,
          each_serializer: CommentSerializer
        )
      )
    end

    # GET /comments/1
    def show
      @comment = Comment.find(params[:id])
      render json: CommentSerializer.new(@comment).to_json
    end

    # POST /comments
    def create
      @comment = Comment.new(comment_params)
      if @comment.save
        render json: @comment
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /comments/1
    def update
      @comment = Comment.find(params[:id])
      if @comment.update(comment_params)
        render json: @comment
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end

    # DELETE /comments/1
    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
    end

    private

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.permit(:owner_name, :comment_text, :news_id)
    end
  end
end
