require 'rails_helper'

RSpec.describe "Favorites Request API" do
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