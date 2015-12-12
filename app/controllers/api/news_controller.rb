module Api
  class NewsController < BaseController
    # User authentication by api key
    before_action :restrict_access, except: [:index, :show]

    # Checking permissions for actions
    load_and_authorize_resource
    skip_authorize_resource only: [:index, :show]

    # User authentications by email and token
    # before_filter :authenticate_user!, only: [:update, :destroy]

    # GET /news
    def index
      @news = News.where(status: News.statuses[:published])
      render(
        json: ActiveModel::ArraySerializer.new(
          @news,
          each_serializer: NewsSerializer
        )
      )
    end

    # GET /news/1
    def show
      @news = News.find(params[:id])
      render json: NewsSerializer.new(@news).to_json
    end

    # POST /news
    def create
      @news = News.new(news_params)
      if @news.save
        render json: @news
      else
        render json: @news.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /news/1
    def update
      @news = News.find(params[:id])
      if @news.update(news_params)
        render json: @news
      else
        render json: @news.errors, status: :unprocessable_entity
      end
    end

    # DELETE /news/1
    def destroy
      @news = News.find(params[:id])
      @news.destroy
    end

    private

    # Only allow a trusted parameter "white list" through.
    def news_params
      params.permit(:news_text, :status, :user_id)
    end
  end
end
