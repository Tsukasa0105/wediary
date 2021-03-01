# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:another_user)
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

  describe '#show' do
    context 'as an authorized user' do
      before do
        session[:user_id] = @user.id
      end
      it 'responds successfully' do
        get :show, params: { id: @user.id }
        expect(response).to be_success
      end
      it 'returns a 200 response' do
        get :show, params: { id: @user.id }
        expect(response).to have_http_status '200'
      end
    end
    context 'as a guest user' do
      it 'does not respond successfully' do
        get :show, params: { id: @user.id }
        expect(response).to_not be_success
      end
      it 'returns a 302 response' do
        get :show, params: { id: @user.id }
        expect(response).to have_http_status '302'
      end
      it 'redirects the page to /login' do
        get :show, params: { id: @user.id }
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe '#new' do
    context 'as an authorized user' do
      before do
        session[:user_id] = @user.id
      end
      it 'responds successfully' do
        get :new
        expect(response).to be_success
      end
      it 'returns a 200 response' do
        get :new
        expect(response).to have_http_status '200'
      end
    end
  end

  describe '#create' do
    context 'as an authorized user' do
      it 'redirects the page to /' do
        post :create, params: {
          user: {
            name: 'user1',
            email: 'user1@gmail.com',
            password: 'user1user1',
            password_confirmation: 'user1user1'
          }
        }
        expect(response).to redirect_to '/login'
      end
    end
    context 'with invalid attributes' do
      it 'does not add a new user' do
        expect {
          post :create, params: {
            user: {
              name: nil
            }
          }
        }.to_not change(User.all, :count)
      end
      it 'redirects the page to groups/new' do
        post :create, params: {
          user: {
            name: nil
          }
        }
        expect(response).to render_template 'users/new'
      end
    end
  end

  describe '#edit' do
    context 'as an authorized user' do
      before do
        session[:user_id] = @user.id
      end
      it 'responds successfully' do
        get :edit, params: { id: @user.id }
        expect(response).to be_success
      end
      it 'returns a 200 response' do
        get :edit, params: { id: @user.id }
        expect(response).to have_http_status '200'
      end
    end
    context 'as a guest user' do
      it 'returns a 302 response' do
        get :edit, params: { id: @user.id }
        expect(response).to have_http_status '302'
      end
      it 'redirects the page to /login' do
        get :edit, params: { id: @user.id }
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe '#update' do
    context 'as an authorized user' do
      before do
        session[:user_id] = @user.id
      end
      it 'updates an user' do
        user_params = { name: 'user2' }
        patch :update, params: { id: @user.id, user: user_params }
        expect(@user.reload.name).to eq 'user2'
      end
      it 'redirects the page to /' do
        user_params = { name: 'user2' }
        patch :update, params: { id: @user.id, user: user_params }
        expect(response).to redirect_to user_path(@user)
      end
    end
    context 'with invalid attributes' do
      before do
        session[:user_id] = @user.id
      end
      it 'does not update an user' do
        user_params = { name: nil }
        patch :update, params: { id: @user.id, user: user_params }
        expect(@user.reload.name).to eq 'user'
      end
      it 'redirects the page to /users/@user.id/edit' do
        user_params = { name: nil }
        patch :update, params: { id: @user.id, user: user_params }
        expect(response).to render_template :edit
      end
    end
    context 'as an unauthorized user' do
      before do
        session[:user_id] = @another_user.id
      end
      it 'does not respond successfully' do
        user_params = { name: "useruser" }
        patch :update, params: { id: @user.id, user: user_params }
        expect(response).to_not be_success
      end
      it 'redirects the page to root_path' do
        user_params = { name: "useruser" }
        patch :update, params: { id: @user.id, user: user_params }
        expect(response).to redirect_to root_path
      end
    end
    context 'as a guest user' do
      it 'returns a 302 response' do
        user_params = { name: 'user2' }
        patch :update, params: { id: @user.id, user: user_params }
        expect(response).to have_http_status '302'
      end
      it 'redirects the page to /users/login' do
        user_params = { name: 'user2' }
        patch :update, params: { id: @user.id, user: user_params }
        expect(response).to redirect_to '/login'
      end
    end
  end
end
