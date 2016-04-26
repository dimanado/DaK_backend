require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe '#show' do
    context 'when user login' do
      let(:index_fields) { ['id', 'email', 'roles'] }
      let(:user) { FactoryGirl.create(:user) }
      let(:params) { get :show, id: user.id}
      let(:json_user) { JSON.parse(response.body) }

      before do
        sign_in(user)
        params
      end

      it 'should be success' do
        expect(response).to be_success
      end

      it 'should return all fields' do
        index_fields.each do |field|
          expect(json_user['users']).to include(field)
        end
      end

      it 'should return correct role' do
        expect(json_user['users']['roles'].first['name']).to eq('user')
      end

      it 'should return user' do
        expect(user.id).to eq(json_user['users']['id'])
      end
    end

    context 'when user logout' do
      let(:params) { get :show, id: 1}

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