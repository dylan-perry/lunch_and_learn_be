class LearningResourceFacade < ApplicationFacade

    def initialize(country)
        @country = country
    end
    
    def resources_by_country
        country_query = process_country_for_services(@country)

        video = video_by_country(country_query)
        images = images_by_country(country_query)

        LearningResourcePoro.new(country_query, video, images)
    end

    def video_by_country(country)
        youtube_service = prepare_service_youtube
        video_result = youtube_service.get_video_by_country(country)
        if video_result
            video_hash = { title: video_result[:snippet][:title], youtube_video_id: video_result[:id][:videoId] }
        else
            video_hash = {}
        end
    end

    def images_by_country(country)
        unsplash_service = prepare_service_unsplash
        image_results = unsplash_service.get_images_by_country(country)
        if image_results
            image_results.map do |image|
                { alt_tag: image[:alt_description], url: image[:urls][:raw] }
            end
        else
            images_array = []
        end
    end
end