require 'rails_helper'

RSpec.describe "Favorite Facade" do
    before :each do
        @user1 = User.create!(name: "Miss Frizzle", email: "thefrizz@gmail.com", password: "donkus", password_confirmation: "donkus")
        @favorite1 = @user1.favorites.create!(recipe_title: "Egyptian Tomato Soup", recipe_link: "https://www.thekitchn.com/recipe-egyptian-tomato-soup-weeknight-dinner-recipes-from-the-kitchn-123308", country: "egypt")
        @favorite2 = @user1.favorites.create!(recipe_title: "Crab Fried Rice (Khaao Pad Bpu)", recipe_link: "https://www.tastingtable.com/687784/crab-fried-rice-recipe-from-chef-bee/", country: "thailand")
        @facade = FavoriteFacade.new(@user1)
    end

    describe "favorites_by_user" do
        it "returns a user's favorites" do
            favorites = @facade.favorites_by_user
    
            favorites.each do |favorite|
                expect(favorite).to be_a FavoritePoro

                expect(favorite.id).to be_a Integer
                expect(favorite.recipe_title).to be_a String
                expect(favorite.recipe_link).to be_a String
                expect(favorite.country).to be_a String
                expect(favorite.created_at).to be_a ActiveSupport::TimeWithZone
            end
        end
    end
end