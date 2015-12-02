require "rails_helper"

RSpec.describe VideoController, :type => :controller do

  describe "#index" do
    context "when user login" do
      let(:index_fields) { ['id', 'email', 'roles'] }
      before do
        @user = FactoryGirl.create(:user)
        sign_in(@user)
        @course = FactoryGirl.create(:course_with_image)
      end

      # it "" do
      #   get :index, id: @course.id
      #   expect(response).to be_success
      # end

    end
  end
end