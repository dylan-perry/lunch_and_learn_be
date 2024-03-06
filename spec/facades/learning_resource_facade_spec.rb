require 'rails_helper'

RSpec.describe "Learning Resource Facade", :vcr do
    before :each do
        @facade = LearningResourceFacade.new("france")
    end

    describe "resources_by_country" do
        it "returns a processed resource by country" do
            resource = @facade.resources_by_country
            
            expect(resource).to be_a LearningResourcePoro
    
            expect(resource.id).to eq(nil)

            expect(resource.video).to be_a Hash
            expect(resource.video[:title]).to be_a String
            expect(resource.video[:youtube_video_id]).to be_a String

            expect(resource.images).to be_a Array

            resource.images.each do |image|
                expect(image[:alt_tag]).to be_a String
                expect(image[:url]).to be_a String
            end

            expect(resource.country).to be_a String
            expect(resource.country).to eq("france")
        end
    end

    describe "video_by_country" do
        it "returns a processed video by country" do
            video = @facade.video_by_country("france")
    
            expect(video).to be_a Hash
            expect(video[:title]).to be_a String
            expect(video[:youtube_video_id]).to be_a String
        end
    end

    describe "images_by_country" do
        it "returns a processed video by country" do
            images = @facade.images_by_country("france")
    
            expect(images).to be_a Array

            images.each do |image|
                expect(image[:alt_tag]).to be_a String
                expect(image[:url]).to be_a String
            end
        end
    end
end