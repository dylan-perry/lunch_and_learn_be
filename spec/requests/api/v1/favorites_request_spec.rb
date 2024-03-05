require 'rails_helper'
require 'helpers/date_helper'

RSpec.describe "Favorites Request API" do
    describe "Favorites Index" do
        describe "happy path" do
            it "returns a list of user's favorites" do
                user1 = User.create!(name: "Miss Frizzle", email: "thefrizz@gmail.com", password: "donkus", password_confirmation: "donkus")
                favorite1 = user1.favorites.create!(recipe_title: "Egyptian Tomato Soup", recipe_link: "https://www.thekitchn.com/recipe-egyptian-tomato-soup-weeknight-dinner-recipes-from-the-kitchn-123308", country: "egypt")
                favorite2 = user1.favorites.create!(recipe_title: "Crab Fried Rice (Khaao Pad Bpu)", recipe_link: "https://www.tastingtable.com/687784/crab-fried-rice-recipe-from-chef-bee/", country: "thailand")

                get "/api/v1/favorites?api_key=#{user1.api_key}"

                result = JSON.parse(response.body, symbolize_names: true)

                expect(response).to be_successful
                expect(response.status).to eq(200)

                expect(result[:data]).to be_a(Array)
                expect(result[:data].count).to eq 2

                # JSON formatting according to front end spec
                expect(result[:data][0][:id]).to eq("1")
                expect(result[:data][0][:type]).to eq("favorite")

                # Exact attribute keys
                expect(result[:data][0][:attributes].count).to eq 4

                expect(result[:data][0][:attributes]).to have_key(:recipe_title)
                expect(result[:data][0][:attributes][:recipe_title]).to be_a(String)
                expect(result[:data][0][:attributes][:recipe_title]).to eq(favorite1.recipe_title)

                expect(result[:data][0][:attributes]).to have_key(:recipe_link)
                expect(result[:data][0][:attributes][:recipe_link]).to be_a(String)
                expect(result[:data][0][:attributes][:recipe_link]).to eq(favorite1.recipe_link)

                expect(result[:data][0][:attributes]).to have_key(:country)
                expect(result[:data][0][:attributes][:country]).to be_a(String)
                expect(result[:data][0][:attributes][:country]).to eq(favorite1.country)

                expect(result[:data][0][:attributes]).to have_key(:created_at)
                expect(result[:data][0][:attributes][:created_at]).to be_a(String)

                json_created_at = DateTime.parse(result[:data][0][:attributes][:created_at])
                parsed_created_at = formatted_datetime(json_created_at)
                expected_created_at = formatted_datetime(favorite1.created_at)

                expect(parsed_created_at).to eq(expected_created_at)

                # Second set of favorite data
                expect(result[:data][1][:id]).to eq("2")
                expect(result[:data][1][:type]).to eq("favorite")

                expect(result[:data][1][:attributes].count).to eq 4

                expect(result[:data][1][:attributes]).to have_key(:recipe_title)
                expect(result[:data][1][:attributes][:recipe_title]).to be_a(String)
                expect(result[:data][1][:attributes][:recipe_title]).to eq(favorite2.recipe_title)

                expect(result[:data][1][:attributes]).to have_key(:recipe_link)
                expect(result[:data][1][:attributes][:recipe_link]).to be_a(String)
                expect(result[:data][1][:attributes][:recipe_link]).to eq(favorite2.recipe_link)

                expect(result[:data][1][:attributes]).to have_key(:country)
                expect(result[:data][1][:attributes][:country]).to be_a(String)
                expect(result[:data][1][:attributes][:country]).to eq(favorite2.country)

                expect(result[:data][1][:attributes]).to have_key(:created_at)
                expect(result[:data][1][:attributes][:created_at]).to be_a(String)
                
                expect(result[:data][1][:attributes]).to have_key(:created_at)
                expect(result[:data][1][:attributes][:created_at]).to be_a(String)
                
                json_created_at = DateTime.parse(result[:data][1][:attributes][:created_at])
                parsed_created_at = formatted_datetime(json_created_at)
                expected_created_at = formatted_datetime(favorite2.created_at)
            end
        end
    end
    
    describe "Favorite Create" do
        describe "happy path" do
            it "creates a favorite for a user" do
                user1 = User.create!(name: "Miss Frizzle", email: "thefrizz@gmail.com", password: "donkus", password_confirmation: "donkus")

                params = {
                    api_key: user1.api_key,
                    country: "thailand",
                    recipe_link: "https://www.tastingtable.com/687784/crab-fried-rice-recipe-from-chef-bee/",
                    recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
                }
                headers = { 
                    "Content-Type": "application/json",
                    "Accept": "application/json"
                }

                post api_v1_favorites_path, headers: headers, params: JSON.generate(params)

                result = JSON.parse(response.body, symbolize_names: true)

                expect(response).to be_successful
                expect(response.status).to eq(201)

                # JSON formatting according to front end spec
                expect(result).to be_a(Hash)

                expect(result[:success]).to eq("Favorite added successfully")
            end
        end

        describe "sad path" do
            it "errors out when api_key does not match existing users" do
                user1 = User.create!(name: "Miss Frizzle", email: "thefrizz@gmail.com", password: "donkus", password_confirmation: "donkus")

                params = {
                    api_key: SecureRandom.hex(32),
                    country: "thailand",
                    recipe_link: "https://www.tastingtable.com/687784/crab-fried-rice-recipe-from-chef-bee/",
                    recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
                }
                headers = { 
                    "Content-Type": "application/json",
                    "Accept": "application/json"
                }

                post api_v1_favorites_path, headers: headers, params: JSON.generate(params)

                result = JSON.parse(response.body, symbolize_names: true)

                expect(response).to_not be_successful
                expect(response.status).to eq(401)

                # JSON formatting according to front end spec
                expect(result).to be_a(Hash)

                expect(result[:error]).to eq("Sorry, your credentials are bad!")
            end
        end
    end
end