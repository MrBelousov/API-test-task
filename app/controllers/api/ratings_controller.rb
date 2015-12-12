module Api
  class RatingsController < ApplicationController
    # PATCH/PUT /ratings
    def update
      @rating = Rating.find(params[:id])
      if @rating.update_attributes(score: params[:score])
        respond_to do |format|
          format.json
        end
      end
    end
  end
end
