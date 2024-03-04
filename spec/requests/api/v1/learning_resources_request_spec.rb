require 'rails_helper'

describe "Learning Resources Request API", :vcr do
    describe "GET Learning Resources by Country" do
        describe "happy path" do
            it "returns a list of learning resources from a given country" do
                get '/api/v1/learning_resources?country=laos'

                expect(response).to be_successful        
                learning_resources = JSON.parse(response.body, symbolize_names: true)

                # JSON formatting according to front end spec
                expect(learning_resources[:data]).to be_a(Hash)

                expect(learning_resources[:data][:id]).to eq(nil)
                expect(learning_resources[:data][:type]).to eq("learning_resource")

                # Exact attribute keys
                expect(learning_resources[:data][:attributes].count).to eq 3

                expect(learning_resources[:data][:attributes]).to have_key(:country)
                expect(learning_resources[:data][:attributes][:country]).to be_a(String)
                expect(learning_resources[:data][:attributes][:country].downcase).to eq("laos")

                expect(learning_resources[:data][:attributes]).to have_key(:video)
                expect(learning_resources[:data][:attributes][:video]).to be_a(Hash)
                expect(learning_resources[:data][:attributes][:video].count).to eq 2

                expect(learning_resources[:data][:attributes][:video]).to have_key(:title)
                expect(learning_resources[:data][:attributes][:video][:title]).to be_a(String)

                expect(learning_resources[:data][:attributes][:video]).to have_key(:youtube_video_id)
                expect(learning_resources[:data][:attributes][:video][:youtube_video_id]).to be_a(String)

                expect(learning_resources[:data][:attributes]).to have_key(:images)
                expect(learning_resources[:data][:attributes][:images]).to be_a(Array)
                expect(learning_resources[:data][:attributes][:images].count).to be < 11 # Max return value of 10 images

                if learning_resources[:data][:attributes][:images].count > 0
                    expect(learning_resources[:data][:attributes][:images]).to be_a(Array)

                    learning_resources[:data][:attributes][:images].each do |image|
                        expect(image).to be_a(Hash)
                        expect(image.count).to eq 2

                        expect(image).to have_key(:alt_tag)
                        expect(image[:alt_tag]).to be_a(String)

                        expect(image).to have_key(:url)
                        expect(image[:url]).to be_a(String)
                    end
                end
            end

            it "returns a list of learning resources from a random country if no country given" do
                get '/api/v1/learning_resources'

                expect(response).to be_successful        
                learning_resources = JSON.parse(response.body, symbolize_names: true)

                # JSON formatting according to front end spec
                expect(learning_resources[:data]).to be_a(Hash)

                expect(learning_resources[:data][:id]).to eq(nil)
                expect(learning_resources[:data][:type]).to eq("learning_resource")

                # Exact attribute keys
                expect(learning_resources[:data][:attributes].count).to eq 3

                expect(learning_resources[:data][:attributes]).to have_key(:country)
                expect(learning_resources[:data][:attributes][:country]).to be_a(String)

                expect(learning_resources[:data][:attributes]).to have_key(:video)
            
                if learning_resources[:data][:attributes][:video].count > 0
                    expect(learning_resources[:data][:attributes][:video]).to be_a(Hash)
                    expect(learning_resources[:data][:attributes][:video].count).to eq 2

                    expect(learning_resources[:data][:attributes][:video]).to have_key(:title)
                    expect(learning_resources[:data][:attributes][:video][:title]).to be_a(String)

                    expect(learning_resources[:data][:attributes][:video]).to have_key(:youtube_video_id)
                    expect(learning_resources[:data][:attributes][:video][:youtube_video_id]).to be_a(String)
                end

                expect(learning_resources[:data][:attributes]).to have_key(:images)
                expect(learning_resources[:data][:attributes][:images]).to be_a(Array)
                expect(learning_resources[:data][:attributes][:images].count).to be < 11 # Max return value of 10 images

                if learning_resources[:data][:attributes][:images].count > 0
                    expect(learning_resources[:data][:attributes][:images]).to be_a(Array)

                    learning_resources[:data][:attributes][:images].each do |image|
                        expect(image).to be_a(Hash)
                        expect(image.count).to eq 2

                        expect(image).to have_key(:alt_tag)
                        expect(image[:alt_tag]).to be_a(String)

                        expect(image).to have_key(:url)
                        expect(image[:url]).to be_a(String)
                    end
                end
            end
        end

        describe "sad path" do
            it "returns an empty videos hash and images array when country param returns no results" do
                get '/api/v1/learning_resources?country=flkdnqalkjerj'

                expect(response).to be_successful  
                learning_resources = JSON.parse(response.body, symbolize_names: true)
        
                expect(learning_resources[:data][:attributes][:video]).to eq({})
                expect(learning_resources[:data][:attributes][:images]).to eq([])
            end
        end
    end
end