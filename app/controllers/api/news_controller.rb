module Api
  class NewsController < ApplicationController
    before_filter :restrict_access, except: [:index, :show]

    # GET /news
    def index
      @news = News.all
      render json: @news
    end

    # GET /news/1
    def show
      @news = News.find(params[:id])
      render json: @news
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
      params.permit(:news_text)
    end

  end
end