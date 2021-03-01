# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @group = FactoryBot.create(:group)
    @map = FactoryBot.create(:map, user: @user, group: @group)
  end

  describe '#index' do
    context 'as an authorized user' do
      before do
        session[:user_id] = @user.id
      end
      it 'responds successfully' do
        get :index
        expect(response).to be_success
      end
      it 'returns a 200 response' do
        get :index
        expect(response).to have_http_status '200'
      end
    end
    context 'as a guest user' do
      it 'does not respond successfully' do
        get :index
        expect(response).to_not be_success
      end
      it 'returns a 302 response' do
        get :index
        expect(response).to have_http_status '302'
      end
      it 'redirects the page to /login' do
        get :index
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe '#create' do
    context 'as an authorized user' do
      before do
        session[:user_id] = @user.id
      end
      it 'redirects the page to /' do
        post :create, params: { 
          map: {
            title: 'map1',
            latitude: 35.000,
            longitude: 140.000,
            user_id: @user.id,
            group_id: @group.id
          }
        }
        expect(response).to redirect_to new_group_event_path(@group.id)
      end
    end
    context 'with invalid attributes' do
      before do
        session[:user_id] = @user.id
      end
      it 'does not add a new map' do
        expect {
         post :create, params: { 
            map: {
              title: nil,
              latitude: 35.000,
              longitude: 140.000,
              user_id: @user.id,
              group_id: @group.id
            }
          }
        }.to_not change(Map.all, :count)
      end
      it 'redirects the page to groups/new' do
        post :create, params: {
          map: {
            title: nil,
            latitude: 35.000,
            longitude: 140.000
          }
        }
        expect(response).to render_template 'maps/index'
      end
    end
    context 'as a guest user' do
      it 'returns a 302 request' do
        get :create
        expect(response).to have_http_status '302'
      end
      it 'redirects the page to /login' do
        get :create
        expect(response).to redirect_to '/login'
      end
    end
  end
end
