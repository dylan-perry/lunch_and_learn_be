class Api::V1::LearningResourcesController < ApplicationController
    def index
        results = LearningResourceFacade.new(params[:country]).resources_by_country
        render json: LearningResourceSerializer.new(results)
    end
end