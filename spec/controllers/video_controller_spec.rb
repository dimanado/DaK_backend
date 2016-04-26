require 'rails_helper'

RSpec.describe VideoController, :type => :controller do

  let(:json_video) { JSON.parse(response.body) }

  describe '#index' do
    let(:video_fields) { ['id', 'name', 'description', 'image'] }
    let(:meta_fields) { ['name', 'description', 'image'] }

    let!(:course) { FactoryGirl.create(:course_with_video) }
    let(:params) { {id_course: course.id} }
    let(:do_request) { get :index, params}


    it 'should be success' do
      do_request
      expect(response).to be_success
    end

    it 'should return video' do
      do_request
      expect(json_video['video'].first['id']).to eq(course.videos.first.id)
    end

    it 'should return meta' do
      do_request
      expect(json_video['meta']['name']).to eq(course.name)
    end

    it 'should return all fields of video' do
      do_request
      json_video['video'].each do |video|
        video_fields.each do |field|
          expect(video).to include(field)
        end
      end
    end

    it 'should return all fields of meta' do
      do_request
      meta_fields.each do |field|
        expect(json_video['meta']).to include(field)
      end
    end

    it 'should invoke Course.new.videos' do
      expect_any_instance_of(Course).to receive(:videos)
      do_request
    end

  end

  describe '#show' do

    let(:do_request) { get :show, id: video.id }
    let!(:video) { FactoryGirl.create(:video_with_image) }

    context 'when user loged in' do
      let(:video_fields) { ['id', 'name', 'url', 'format', 'description', 'image'] }
      let(:user) { FactoryGirl.create(:user) }

      before do
        sign_in(user)
        do_request
      end

      it 'should be success' do
        expect(response).to be_success
      end

      it 'should return all fields of video' do
        video_fields.each do |field|
          expect(json_video['video']).to include(field)
        end
      end

      it 'should return video' do
        expect(json_video['video']['id']).to eq(video.id)
      end

      it 'should return image of video' do
        expect(json_video['video']['image']).to eq(video.image.full_url(:course_sketch))
      end

    end

    context 'when user loged out' do

      before { do_request }

      it 'should return bad response' do
        expect(response).to_not be_success
      end

      it 'should return 401' do
        expect(response.status).to eq(401)
      end
    end
  end

  describe '#create' do

    let!(:course) { FactoryGirl.create(:course) }
    let(:do_request) { post :create, id_course: course.id }
    let!(:video) { FactoryGirl.create(:video_with_image) }

    context 'when user loged in' do
      let(:user) { FactoryGirl.create(:lecturer) }

      before do
        sign_in(user)
        allow_any_instance_of(Video).
            to receive(:build_image).and_return(true)
        allow_any_instance_of(VideoController).
            to receive(:image_params).and_return('1')
        allow_any_instance_of(VideoController).
            to receive(:video_params).and_return({name: '123'})
        allow_any_instance_of(Video).
            to receive(:save).and_return(true)
      end

      it 'should be success' do
        do_request
        expect(response).to be_success
      end

    end

    context 'when user loged out' do
      before do
        do_request
      end

      it 'should not be success' do
        expect(response).to_not be_success
      end

      it 'should return 401' do
        expect(response.status).to eq(401)
      end
    end
  end

end