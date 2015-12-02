require "rails_helper"

RSpec.describe CoursesController, :type => :controller do

  describe "#index" do
    context "when user login" do
      let(:index_fields) { ['id', 'name', 'image'] }
      before do
        @user = FactoryGirl.create(:user)
        sign_in(@user)
        @course = FactoryGirl.create(:course_with_image)
      end

      it "should return all courses" do
        get :index, all: true
        expect(response).to be_success
        json_course = JSON.parse(response.body)
        expect(json_course['courses'].count).to eq(1)
        json_course['courses'].each do |course|
          index_fields.each do |field|
            expect(course).to include(field)
          end
        end
      end

      it "should not return courses for admin" do
        sign_in(FactoryGirl.create(:admin))
        get :index
        expect(response).to be_success
        json_course = JSON.parse(response.body)
        expect(json_course['courses'].count).to eq(0)
      end

      it "should return sub courses for admin" do
        sign_in(user = FactoryGirl.create(:admin_with_course))
        get :index
        expect(response).to be_success
        json_course = JSON.parse(response.body)
        expect(json_course['courses'].count).to eq(user.subscription.courses.count)
      end

      it "should not return courses for lecturer" do
        sign_in(FactoryGirl.create(:lecturer))
        get :index
        expect(response).to be_success
        json_course = JSON.parse(response.body)
        expect(json_course['courses'].count).to eq(0)
      end

      it "should return sub courses for lecturer" do
        sign_in(user = FactoryGirl.create(:lecturer_with_course))
        get :index
        expect(response).to be_success
        json_course = JSON.parse(response.body)
        expect(json_course['courses'].count).to eq(user.courses.count)
      end
    end
    context "when user logout" do
      before do
        @course = FactoryGirl.create(:course_with_image)
      end

      it "should return all courses" do
        get :index, all: true
        expect(response).to be_success
        json_course = JSON.parse(response.body)
        expect(json_course['courses'].count).to eq(1)
      end

      it "should return 403" do
        get :index
        expect(response).to_not be_success
        expect(response.status).to eq(403)
      end
    end
  end

  describe "#create" do
    context "when user login" do
      before do
        @user = FactoryGirl.create(:lecturer)
        sign_in(@user)
      end

      it "should not return courses for admin" do
        allow_any_instance_of(Course).to receive(:build_image).and_return(true)
        allow_any_instance_of(CoursesController).to receive(:image_params).and_return('1')
        post :create, name: 'c++', description: '123'
        expect(response).to be_success
        expect(@user.courses.count).to eq(1)
      end

      it "should return 403" do
        sign_in(FactoryGirl.create(:user))
        post :create, name: 'c++', description: '123'
        expect(response).to_not be_success
        expect(response.status).to eq(403)
      end
    end
    context "when user logout" do
      it "should return 401" do
        post :create, name: 'c++', description: '123'
        expect(response).to_not be_success
        expect(response.status).to eq(401)
      end
    end
  end

end