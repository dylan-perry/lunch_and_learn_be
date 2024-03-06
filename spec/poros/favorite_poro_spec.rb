require 'rails_helper'
require 'helpers/date_helper'

RSpec.describe "Favorite Poro" do
    before :each do
        @user1 = User.create!(name: "Miss Frizzle", email: "thefrizz@gmail.com", password: "donkus", password_confirmation: "donkus")
        @favorite1 = @user1.favorites.create!(recipe_title: "Egyptian Tomato Soup", recipe_link: "https://www.thekitchn.com/recipe-egyptian-tomato-soup-weeknight-dinner-recipes-from-the-kitchn-123308", country: "egypt")
    end

    it "instantiates all attributes" do
        poro1 = FavoritePoro.new(@favorite1)

        expect(poro1.id).to eq(1)
        expect(poro1.recipe_title).to eq(@favorite1.recipe_title)
        expect(poro1.recipe_link).to eq(@favorite1.recipe_link)
        expect(poro1.country).to eq(@favorite1.country)
        expect(poro1.created_at).to eq(@favorite1.created_at)
    end
end