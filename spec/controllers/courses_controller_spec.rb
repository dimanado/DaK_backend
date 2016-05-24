require 'rails_helper'

RSpec.describe CoursesController, type: :controller do

  let(:json_course) { JSON.parse(response.body) }

  describe '#index' do
    let!(:course) { FactoryGirl.create(:course_with_image) }
    let(:params) { {all: true} }

    context 'when user loged in' do
      let(:index_fields) { ['id', 'name', 'image'] }
      let(:user) { FactoryGirl.create(:user) }


      context 'and has role user' do
        let(:do_request) { get :index, params}
        let(:user) { FactoryGirl.create(:user) }

        before do
          sign_in(user)
          do_request
        end

        it 'should be success' do
          expect(response).to be_success
        end

        it 'should return course' do
          expect(json_course['courses'].count).to eq(1)
        end

        it 'should return all fields' do
          json_course['courses'].each do |course|
            index_fields.each do |field|
              expect(course).to include(field)
            end
          end
        end
      end

      context 'and has role admin' do
        let(:do_request) { get :index}
        let(:user) { FactoryGirl.create(:admin_with_course) }

        before do
          sign_in(user)
          do_request
        end

        it 'should be success' do
          expect(response).to be_success
        end

        it 'should return sub courses' do
          expect(json_course['courses'].count).to eq(user.subscription.courses.count)
        end

      end

      context 'and has role admin' do
        let(:do_request) { get :index}
        let(:user) { FactoryGirl.create(:lecturer_with_course) }

        before do
          sign_in(user)
          do_request
        end

        it 'should be success' do
          expect(response).to be_success
        end

        it 'should return courses' do
          expect(json_course['courses'].count).to eq(user.courses.count)
        end
      end
    end

    context 'when user logout' do

      context 'and params have all' do
        before {get :index, params}

        it 'should be success' do
          expect(response).to be_success
        end

        it 'should return all courses' do
          expect(json_course['courses'].count).to eq(1)
        end
      end

      context 'and params have not all' do
        before {get :index}

        it 'should not be success' do
          expect(response).to_not be_success
        end

        it 'should return 403' do
          expect(response.status).to eq(403)
        end
      end
    end
  end

  describe '#create' do
    let(:params) { {name: 'c++', description: '123'} }
    let(:do_request) { post :create, params}

    context 'when user login' do

      context 'and has role lecturer ' do
        let(:user) { FactoryGirl.create(:lecturer) }
        let(:course) { double :course }
        let(:courses) { double :courses }
        before do
          sign_in(user)
          allow_any_instance_of(Course).
              to receive(:build_image).and_return(true)
          allow_any_instance_of(CoursesController).
              to receive(:image_params).and_return('1')
          allow(user).to receive(:courses).and_return(courses)
          allow(courses).to receive(:new).and_return(course)
          allow(course).to receive(:build_image)
          allow(course).to receive(:save).and_return(:true)
          # do_request
        end

        it 'should be success' do
          expect(response).to be_success
        end

        # it 'should create course' do
        #   expect(user.courses.count).to eq(1)
        # end

        # it 'should build course' do
        #   expect(user).to receive(:courses)
        #   expect(courses).to receive(:new).and_return(course)
        #   do_request
        # end

      end

      context 'and has role user ' do
        before do
          sign_in(FactoryGirl.create(:user))
          do_request
        end

        it 'should not be success' do
          expect(response).to_not be_success
        end

        it 'should return 403' do
          expect(response.status).to eq(403)
        end


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