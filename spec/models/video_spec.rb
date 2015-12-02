require "rails_helper"

RSpec.describe Video, :type => :model do
  describe 'full_url' do
    before do
      @image = FactoryGirl.create(:video)
    end

    it 'should return url to video' do
      expect(@image.full_url.nil?).to eq(false)
      expect(@image.full_url.should include ('vd.mp4')).to eq(true)
      expect(@image.full_url.should include ('http://localhost:3000')).to eq(true)
    end
  end
end