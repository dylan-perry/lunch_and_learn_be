require 'rails_helper'

RSpec.describe "Recipe Facade" do
    before :each do
        @facade = RecipeFacade.new("france")
    end

    describe "recipes_by_country", :vcr do
        it "returns processed recipes by country" do
            recipes = @facade.recipes_by_country
    
            recipes.each do |recipe|
                expect(recipe).to be_a RecipePoro

                expect(recipe.id).to eq(nil)

                expect(recipe.title).to be_a String
                expect(recipe.url).to be_a String
                expect(recipe.country).to be_a String
                expect(recipe.country).to eq "france"
                expect(recipe.image).to be_a String
            end
        end
    end
end