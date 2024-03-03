require 'rails_helper'

describe "Recipes Request API", :vcr do
    describe "GET Recipes by Country" do
        describe "happy path" do
            it "returns a list of recipes from a given country" do
                get '/api/v1/recipes?country=thailand'
        
                expect(response).to be_successful        
                recipes = JSON.parse(response.body, symbolize_names: true)
        
                expect(recipes[:data]).to be_a(Array)
        
                recipes[:data].each do |recipe|
                    # JSON formatting according to front end spec
                    expect(recipe[:id]).to eq(nil)
                    expect(recipe[:type]).to eq("recipe")

                    # Exact attribute keys
                    expect(recipe[:attributes]).to have_key(:title)
                    expect(recipe[:attributes][:title]).to be_a(String)
                    expect(recipe[:attributes]).to have_key(:url)
                    expect(recipe[:attributes][:url]).to be_a(String)
                    expect(recipe[:attributes]).to have_key(:country)
                    expect(recipe[:attributes][:country]).to be_a(String)
                    expect(recipe[:attributes]).to have_key(:image)
                    expect(recipe[:attributes][:image]).to be_a(String)
                    
                    expect(recipe[:attributes].count).to eq 4

                    expect(recipe[:attributes][:country].downcase).to eq("thailand")
                end
            end

            it "returns a list of recipes from a random country when no country given" do
                get '/api/v1/recipes'

                expect(response).to be_successful        
                recipes = JSON.parse(response.body, symbolize_names: true)
        
                expect(recipes[:data]).to be_a(Array)
        
                recipes[:data].each do |recipe|
                    # JSON formatting according to front end spec
                    expect(recipe[:id]).to eq(nil)
                    expect(recipe[:type]).to eq("recipe")

                    # Exact attribute keys
                    expect(recipe[:attributes]).to have_key(:title)
                    expect(recipe[:attributes][:title]).to be_a(String)
                    expect(recipe[:attributes]).to have_key(:url)
                    expect(recipe[:attributes][:url]).to be_a(String)
                    expect(recipe[:attributes]).to have_key(:country)
                    expect(recipe[:attributes][:country]).to be_a(String)
                    expect(recipe[:attributes]).to have_key(:image)
                    expect(recipe[:attributes][:image]).to be_a(String)
                    
                    expect(recipe[:attributes].count).to eq 4
                end
            end
        end

        describe "sad path" do
            it "returns an empty array when country param is empty" do
                get '/api/v1/recipes?country='

                expect(response).to be_successful  
                recipes = JSON.parse(response.body, symbolize_names: true)
        
                expect(recipes[:data]).to be_a(Array)
                expect(recipes[:data]).to eq([])
            end

            it "returns an empty array when country param returns no results" do
                get '/api/v1/recipes?country=zaboomafoo'

                expect(response).to be_successful  
                recipes = JSON.parse(response.body, symbolize_names: true)
        
                expect(recipes[:data]).to be_a(Array)
                expect(recipes[:data]).to eq([])
            end
        end
    end
end
