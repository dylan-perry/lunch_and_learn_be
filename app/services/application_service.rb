class ApplicationService
    def get_url(url)
        processed_url = process_for_url(url)
        response = conn.get(processed_url)
        JSON.parse(response.body, symbolize_names: true)
    end

    def process_for_url(query)
        query.gsub(" ", "%20")
    end
end