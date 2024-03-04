class Api::V1::AirQualityController < ApplicationController
    def index
        results = AirQualityFacade.new(params[:country]).air_quality_by_country
        render json: AirQualitySerializer.new(results)
    end
end