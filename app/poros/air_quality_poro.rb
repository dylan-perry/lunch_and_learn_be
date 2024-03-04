class AirQualityPoro
    attr_reader :id, :aqi, :datetime, :readable_aqi

    def initialize(air_quality_hash)
        @id = nil
        @aqi = air_quality_hash[:aqi]
        @datetime = air_quality_hash[:datetime]
        @readable_aqi = readable_aqi_enum(air_quality_hash[:aqi])
    end

    def readable_aqi_enum(aqi)
        enum = [nil, "Good", "Fair", "Moderate", "Poor", "Very Poor"]
        enum[aqi]
    end
end