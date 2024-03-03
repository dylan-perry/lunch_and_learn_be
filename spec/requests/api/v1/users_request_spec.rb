require 'rails_helper'

RSpec.describe "Users Request API" do
    describe "User Create" do
        describe "happy path" do
            it "creates a user" do
                user_params = {
                    name: "Miss Frizzle",
                    email: "thefrizz@gmail.com",
                    password: "donkus",
                    password_confirmation: "donkus"
                }
                headers = { 
                    "Content-Type": "application/json",
                    "Accept": "application/json"
                }

                post api_v1_users_path, headers: headers, params: JSON.generate(user_params)

                new_user = User.last

                expect(response).to be_successful
                expect(response.status).to eq(201)

                expect(new_user.name).to eq(user_params[:name])
                expect(new_user.email).to eq(user_params[:email])
                expect(new_user.password).to eq(user_params[:password_digest])
            end
        end

        describe "sad path" do
            it "errors out when an email already exists" do
                user1 = User.create!(name: "Miss Frizzle", email: "thefrizz@gmail.com", password: "donkus", password_confirmation: "donkus")

                user_params = {
                    name: "Miss Frizzle",
                    email: "THEFRIZZ@gmail.com",
                    password: "donkus",
                    password_confirmation: "donkus"
                }
                headers = { 
                    "Content-Type": "application/json",
                    "Accept": "application/json"
                }

                post api_v1_users_path, headers: headers, params: JSON.generate(user_params)

                expect(response).to_not be_successful 
                expect(response).to have_http_status(401)
            end
        end
    end
end