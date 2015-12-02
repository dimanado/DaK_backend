require "rails_helper"

RSpec.describe SubscriptionsController, :type => :controller do

  describe "#add_course" do
    context "when user login" do
      before do
        @user = FactoryGirl.create(:user)
        sign_in(@user)
        @course = FactoryGirl.create(:course_with_image)
      end

      it "should add course to subscription" do
        post :add_course, id: @course.id
        expect(response).to be_success
        expect(@user.subscription.courses.first.id).to eq(@course.id)
      end

      it "should not add course if it is exist" do
        allow_any_instance_of(User).to receive_message_chain(:subscription,
          :courses, :find_by) { @course }
        post :add_course, id: @course.id
        expect(response).to_not be_success
        expect(response.status).to eq(400)
        expect(JSON.parse(response.body)['error']).to eq(
          'course has already been created')
      end
    end
    context "when user login" do
      it "should return 401" do
        post :add_course, id: 1
        expect(response).to_not be_success
        expect(response.status).to eq(401)
      end
    end
  end

  describe "#check_status" do
    context "when user login" do
      before do
        @user = FactoryGirl.create(:user)
        sign_in(@user)
        @course = FactoryGirl.create(:course_with_image)
      end

      it "should return success false when user not subscribe for course" do
        get :check_status, id: @course.id
        expect(response).to be_success
        expect(JSON.parse(response.body)['success']).to eq(false)
      end

      it "should return success true when user subscribe for course" do
        allow_any_instance_of(User).to receive_message_chain(:subscription,
          :courses, :find_by) { @course }
        get :check_status, id: @course.id
        expect(response).to be_success
        expect(JSON.parse(response.body)['success']).to eq(true)
      end
    end
    context "when user login" do
      it "should return 401" do
       get :check_status, id: 1
        expect(response).to_not be_success
        expect(response.status).to eq(401)
      end
    end
  end
end