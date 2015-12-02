require "rails_helper"

RSpec.describe Image, :type => :model do
  describe 'full_url' do
    before do
    @image = FactoryGirl.create(:image)
    end

    it 'should return url to image' do
      expect(@image.full_url(:course_sketch).nil?).to eq(false)
      expect(@image.full_url(:course_sketch)
             .should include ('course_sketch_apple.png')).to eq(true)
      expect(@image.full_url(:course_sketch)
             .should include ('http://localhost:3000')).to eq(true)
    end
  end
end