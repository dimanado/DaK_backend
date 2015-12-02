require "rails_helper"

RSpec.describe UsersController, :type => :controller do

  describe "#show" do
    context "when user login" do
      let(:index_fields) { ['id', 'email', 'roles'] }
      before do
        @user = FactoryGirl.create(:user)
        sign_in(@user)
      end

      it "should return user" do
        get :show, id: @user.id
        expect(response).to be_success
        json_user = JSON.parse(response.body)
        index_fields.each do |field|
          expect(json_user['users']).to include(field)
        end
        expect( @user.id).to eq(json_user['users']['id'])
        expect(json_user['users']['roles'].first['name']).to eq('user')
      end
    end

    context "when user logout" do
      it "should return 401" do
        get :show, id: 1
        expect(response).to_not be_success
        expect(response.status).to eq(401)
      end
    end
  end
end