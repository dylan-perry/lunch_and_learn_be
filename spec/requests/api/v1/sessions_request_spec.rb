require 'rails_helper'

RSpec.describe "Sessions Request API" do
    describe "Session Create" do
        describe "happy path" do
            it "creates a session / logs in a user" do
                user1 = User.create!(name: "Miss Frizzle", email: "thefrizz@gmail.com", password: "donkus", password_confirmation: "donkus")

                user_params = {
                    email: "thefrizz@gmail.com",
                    password: "donkus",
                }
                headers = { 
                    "Content-Type": "application/json",
                    "Accept": "application/json"
                }

                post api_v1_sessions_path, headers: headers, params: JSON.generate(user_params)

                result = JSON.parse(response.body, symbolize_names: true)

                expect(response).to be_successful
                expect(response.status).to eq(200)

                # JSON formatting according to front end spec
                expect(result[:data]).to be_a(Hash)

                expect(result[:data][:id]).to eq("1")
                expect(result[:data][:type]).to eq("user")

                # Exact attribute keys
                expect(result[:data][:attributes].count).to eq 3

                expect(result[:data][:attributes]).to have_key(:name)
                expect(result[:data][:attributes][:name]).to be_a(String)
                expect(result[:data][:attributes][:name]).to eq("Miss Frizzle")

                expect(result[:data][:attributes]).to have_key(:email)
                expect(result[:data][:attributes][:email]).to be_a(String)
                expect(result[:data][:attributes][:email]).to eq("thefrizz@gmail.com")

                expect(result[:data][:attributes]).to have_key(:api_key)
                expect(result[:data][:attributes][:api_key]).to be_a(String)
                expect(result[:data][:attributes][:api_key]).to eq(User.last.api_key)

            end
        end

        describe "sad path" do
            it "errors out when user password is incorrect" do
                user1 = User.create!(name: "Miss Frizzle", email: "thefrizz@gmail.com", password: "donkus", password_confirmation: "donkus")

                user_params = {
                    email: "thefrizz@gmail.com",
                    password: "ferp",
                }
                headers = { 
                    "Content-Type": "application/json",
                    "Accept": "application/json"
                }

                post api_v1_sessions_path, headers: headers, params: JSON.generate(user_params)

                expect(response).to_not be_successful 
                expect(response).to have_http_status(401)

                result = JSON.parse(response.body, symbolize_names: true)
                
                expect(result[:error]).to eq("Sorry, your credentials are bad!")
            end

            it "errors out when user email is incorrect" do
                user1 = User.create!(name: "Miss Frizzle", email: "thefrizz@gmail.com", password: "donkus", password_confirmation: "donkus")

                user_params = {
                    email: "thefart@gmail.com",
                    password: "donkus",
                }
                headers = { 
                    "Content-Type": "application/json",
                    "Accept": "application/json"
                }

                post api_v1_sessions_path, headers: headers, params: JSON.generate(user_params)

                expect(response).to_not be_successful 
                expect(response).to have_http_status(401)

                result = JSON.parse(response.body, symbolize_names: true)

                expect(result[:error]).to eq("Sorry, your credentials are bad!")
            end

            it "errors out when user email and password are incorrect" do
                user1 = User.create!(name: "Miss Frizzle", email: "thefrizz@gmail.com", password: "donkus", password_confirmation: "donkus")

                user_params = {
                    email: "thefart@gmail.com",
                    password: "blork",
                }
                headers = { 
                    "Content-Type": "application/json",
                    "Accept": "application/json"
                }

                post api_v1_sessions_path, headers: headers, params: JSON.generate(user_params)

                expect(response).to_not be_successful 
                expect(response).to have_http_status(401)

                result = JSON.parse(response.body, symbolize_names: true)

                expect(result[:error]).to eq("Sorry, your credentials are bad!")
            end
        end
    end
end