require 'rails_helper'

RSpec.describe Image, type: :model do

  describe '#full_url' do
    let(:image) {FactoryGirl.create(:image)}

    it 'should be exist' do
      expect(image.full_url(:course_sketch).present?).to eq(true)
    end

    it 'should return image' do
      expect(image.full_url(:course_sketch)
                 .should include ('course_sketch_apple.png')).to eq(true)
    end
    it 'should return host and port' do

      expect(image.full_url(:course_sketch)
                 .should include ('http://localhost:3000')).to eq(true)
    end
  end
end