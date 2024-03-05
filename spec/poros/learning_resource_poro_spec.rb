require 'rails_helper'

RSpec.describe "Learning Resource Poro" do
    before :each do
        @country = "france"
        @video = {title: "Holy gosh, it's a France Video", url: "https://videourl.com"}
        @images = [
            {alt_tag: "cool image 1", url: "https://coolimage.com/1"},
            {alt_tag: "cool image 1", url: "https://coolimage.com/2"},
            {alt_tag: "cool image 1", url: "https://coolimage.com/3"}
        ]
        @poro1 = LearningResourcePoro.new(@country, @video, @images)
    end

    it "instantiates all attributes" do
        expect(@poro1.id).to eq(nil)
        expect(@poro1.country).to eq(@country)
        expect(@poro1.video).to eq(@video)
        expect(@poro1.images).to eq(@images)
    end
end