class YoutubeService < ApplicationService

    def conn
        Faraday.new(url: "https://www.googleapis.com/youtube/v3/search") do |faraday|
            faraday.params["key"] = Rails.application.credentials.youtube[:key]
            faraday.headers['Accept'] = 'application/json'
        end
    end
    
    def get_video_by_country(country)
        get_url("https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=1&q=#{country}&channelId=UCluQ5yInbeAkkeCndNnUhpw")[:items].first
    end
end
