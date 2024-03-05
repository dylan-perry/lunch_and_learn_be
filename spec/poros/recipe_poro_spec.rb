require 'rails_helper'

RSpec.describe "Recipe Poro" do
    before :each do
        @recipe = {
            recipe: {
                label: "Cool Recipe",
                url: "https://coolrecipes.com/1",
                image: "https://imageurl.com"
            }
        }
        @country = "france"
        
        @poro1 = RecipePoro.new(@recipe, @country)
    end

    it "instantiates all attributes" do
        expect(@poro1.id).to eq(nil)
        expect(@poro1.country).to eq(@country)
        expect(@poro1.title).to eq(@recipe[:recipe][:label])
        expect(@poro1.url).to eq(@recipe[:recipe][:url])
        expect(@poro1.image).to eq(@recipe[:recipe][:image])
    end
end