class AirQualityPoro
    attr_reader :id, :aqi, :datetime, :readable_aqi

    def initialize(air_quality_hash)
        @id = nil
        @aqi = air_quality_hash[:aqi]
        @datetime = air_quality_hash[:datetime]
        if air_quality_hash[:aqi] == 1
            @readable_aqi = "Good"
        elsif air_quality_hash[:aqi] == 2
            @readable_aqi = "Fair"
        elsif air_quality_hash[:aqi] == 3
            @readable_aqi = "Moderate"
        elsif air_quality_hash[:aqi] == 4
            @readable_aqi = "Poor"
        elsif air_quality_hash[:aqi] == 5
            @readable_aqi = "Very Poor"
        end
    end
end