require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do

  describe '#add_course' do
    context 'when user loged in' do
      let(:user) {FactoryGirl.create(:user)}
      let!(:course) {FactoryGirl.create(:course_with_image)}
      let(:params) {post :add_course, id: course.id}
      let(:stub_user) {allow_any_instance_of(User)
                           .to receive_message_chain(:subscription,
                                                     :courses,
                                                     :find_by) { course }}
      before do
        sign_in(user)
      end
      context 'when not subscribe' do
        before {params}

        it 'should be success' do
          expect(response).to be_success
        end

        it 'should add course' do
          expect(user.subscription.courses.first.id).to eq(course.id)
        end
      end

      context 'when subscribe' do
        before do
          stub_user
          params
        end
        it 'should be not success' do
          expect(response).to_not be_success
        end

        it 'should return 400' do
          expect(response.status).to eq(400)
        end

        it 'should exist error field' do
          expect(JSON.parse(response.body)['error']).
              to eq('course has already been created')
        end
      end
    end
    context 'when user loged out' do
      let(:params) {post :add_course, id: 1}

      before { params }

      it 'should return bad response' do
        expect(response).to_not be_success
      end

      it 'should return 401' do
        expect(response.status).to eq(401)
      end
    end
  end

  describe '#check_status' do
    context 'when user login' do
      let(:user) {FactoryGirl.create(:user)}
      let!(:course) {FactoryGirl.create(:course_with_image)}
      let(:params) {get :check_status, id: course.id}
      let(:stub_user) {allow_any_instance_of(User)
                           .to receive_message_chain(:subscription,
                                                     :courses,
                                                     :find_by) { course }}
      before do
        sign_in(user)
      end

      context 'when not subscribe' do
        before {params}

        it 'should be success' do
          expect(response).to be_success
        end

        it 'should return success false' do
          expect(JSON.parse(response.body)['success']).to eq(false)
        end
      end

      context 'when subscribe' do
        before do
          stub_user
          params
        end

        it 'should be success' do
          expect(response).to be_success
        end

        it 'should return success true' do
          expect(JSON.parse(response.body)['success']).to eq(true)
        end

      end
    end
    context 'when user login' do
      let(:params) {get :check_status, id: 1}

      before { params }

      it 'should return bad response' do
        expect(response).to_not be_success
      end

      it 'should return 401' do
        expect(response.status).to eq(401)
      end
    end
  end
end