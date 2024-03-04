require 'rails_helper'

describe "Air Quality Request API", :vcr do
    describe "GET Air Quality by Country" do
        describe "happy path" do
            it "returns the air quality by country" do
                get '/api/v1/air_quality?country=India'

                expect(response).to be_successful        
                air_quality = JSON.parse(response.body, symbolize_names: true)

                # JSON formatting according to front end spec
                expect(air_quality[:data]).to be_a(Hash)

                expect(air_quality[:data][:id]).to eq(nil)
                expect(air_quality[:data][:type]).to eq("air_quality")

                # Exact attribute keys
                expect(air_quality[:data][:attributes].count).to eq 3

                expect(air_quality[:data][:attributes]).to have_key(:aqi)
                expect(air_quality[:data][:attributes][:aqi]).to be_a(Integer)
                expect(air_quality[:data][:attributes][:aqi]).to be 2

                expect(air_quality[:data][:attributes]).to have_key(:datetime)
                expect(air_quality[:data][:attributes][:datetime]).to be_a(Integer)
                expect(air_quality[:data][:attributes][:datetime]).to be > 0

                expect(air_quality[:data][:attributes]).to have_key(:readable_aqi)
                expect(air_quality[:data][:attributes][:readable_aqi]).to be_a(String)
                expect(air_quality[:data][:attributes][:readable_aqi]).to eq("Fair")


                # Testing other readable_aqi statuses
                # get '/api/v1/air_quality?country=France'
            end

            it "returns a list of learning resources from a random country if no country given" do
                get '/api/v1/air_quality'

                expect(response).to be_successful        
                air_quality = JSON.parse(response.body, symbolize_names: true)

                # JSON formatting according to front end spec
                expect(air_quality[:data]).to be_a(Hash)

                expect(air_quality[:data][:id]).to eq(nil)
                expect(air_quality[:data][:type]).to eq("air_quality")

                # Exact attribute keys
                expect(air_quality[:data][:attributes].count).to eq 3

                expect(air_quality[:data][:attributes]).to have_key(:aqi)
                expect(air_quality[:data][:attributes][:aqi]).to be_a(Integer)
                expect(air_quality[:data][:attributes][:aqi]).to be > 0

                expect(air_quality[:data][:attributes]).to have_key(:datetime)
                expect(air_quality[:data][:attributes][:datetime]).to be_a(Integer)
                expect(air_quality[:data][:attributes][:datetime]).to be > 0

                expect(air_quality[:data][:attributes]).to have_key(:readable_aqi)
                expect(air_quality[:data][:attributes][:readable_aqi]).to be_a(String)
            end
        end

        # describe "sad path" do
        #     it "returns an empty videos hash and images array when country param returns no results" do
        #         get '/api/v1/learning_resources?country=flkdnqalkjerj'

        #         expect(response).to be_successful  
        #         learning_resources = JSON.parse(response.body, symbolize_names: true)
        
        #         expect(learning_resources[:data][:attributes][:video]).to eq({})
        #         expect(learning_resources[:data][:attributes][:images]).to eq([])
        # #     end
        # end
    end
end