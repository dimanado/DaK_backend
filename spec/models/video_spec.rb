require 'rails_helper'

RSpec.describe Video, type: :model do
  describe '#full_url' do
    let(:video) {FactoryGirl.create(:video)}

    it 'should be exist' do
      expect(video.full_url.present?).to eq(true)
    end

    it 'should return host and port' do
      expect(video.full_url.
                 should include ('http://localhost:3000')).to eq(true)
    end

    it 'should return video' do
      expect(video.full_url.should include ('vd.mp4')).to eq(true)

    end
  end
end