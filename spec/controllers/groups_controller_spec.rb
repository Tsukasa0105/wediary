
require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:another_user)
    @group = FactoryBot.create(:group)
    @user.member(@group)
    @group.permit_member(@user)
  end

  describe '#show' do
    context 'as an authorized user' do
      before do
        session[:user_id] = @user.id
      end
      it 'responds successfully' do
        get :show, params: { id: @group.id }
        expect(response).to be_success
      end
      it 'returns a 200 response' do
        get :show, params: { id: @group.id }
        expect(response).to have_http_status '200'
      end
    end
    context 'as a guest user' do
      it 'does not respond successfully' do
        get :show, params: { id: @group.id }
        expect(response).to_not be_success
      end
      it 'returns a 302 response' do
        get :show, params: { id: @group.id }
        expect(response).to have_http_status '302'
      end
      it 'redirects the page to /login' do
        get :show, params: { id: @group.id }
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
    context 'as a guest user' do
      it 'does not respond successfully' do
        get :new
        expect(response).to_not be_success
      end
      it 'returns a 302 response' do
        get :new
        expect(response).to have_http_status '302'
      end
      it 'redirects the page to /login' do
        get :new
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
          group: {
            name: 'another_user',
            key: 'another_user'
          }
        }
        expect(response).to redirect_to '/'
      end
    end
    context 'with invalid attributes' do
      before do
        session[:user_id] = @user.id
      end
      it 'redirects the page to groups/new' do
        post :create, params: {
          group: {
            name: nil,
            key: 'another_user'
          }
        }
        expect(response).to render_template 'groups/new'
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

  describe '#edit' do
    context 'as an authorized user' do
      before do
        session[:user_id] = @user.id
      end
      it 'responds successfully' do
        get :edit, params: { id: @group.id }
        expect(response).to be_success
      end
      it 'returns a 200 response' do
        get :edit, params: { id: @group.id }
        expect(response).to have_http_status '200'
      end
    end
    context 'as a guest user' do
      it 'returns a 302 response' do
        get :edit, params: { id: @group.id }
        expect(response).to have_http_status '302'
      end
      it 'redirects the page to /login' do
        get :edit, params: { id: @group.id }
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe '#update' do
    context 'as an authorized user' do
      before do
        session[:user_id] = @user.id
      end
      it 'updates an group' do
        group_params = { name: 'group2' }
        patch :update, params: { id: @group.id, group: group_params }
        expect(@group.reload.name).to eq 'group2'
      end
      it 'redirects the page to group/show' do
        group_params = { name: 'name2' }
        patch :update, params: { id: @group.id, group: group_params }
        expect(response).to redirect_to "/groups/#{@group.id}"
      end
    end
    context 'with invalid attributes' do
      before do
        session[:user_id] = @user.id
      end
      it 'does not update an group without name' do
        group_params = { name: nil }
        patch :update, params: { id: @group.id, group: group_params }
        expect(@group.reload.name).to eq 'group'
      end
      it 'redirects the page to /groups/group.id/edit' do
        group_params = { name: nil }
        patch :update, params: { id: @group.id, group: group_params }
        expect(response).to render_template :edit
      end
    end
    context 'as an unauthorized user' do
      before do
        session[:user_id] = @another_user.id
      end
      it 'does not update without joining group' do
        group_params = { name: "group3" }
        patch :update, params: { id: @group.id, group: group_params }
        expect(@group.reload.name).to eq 'group'
      end
      it 'redirects the page to /groups/group.id/edit' do
        group_params = { name: "group4" }
        patch :update, params: { id: @group.id, group: group_params }
        expect(response).to render_template :edit
      end
    end
    context 'as a guest user' do
      it 'does not respond successfully' do
        get :edit, params: { id: @group.id }
        expect(response).to_not be_success
      end
      it 'returns a 302 response' do
        group_params = { name: 'group2' }
        patch :update, params: { id: @group.id, group: group_params }
        expect(response).to have_http_status '302'
      end
      it 'redirects the page to /users/login' do
        group_params = { name: 'group2' }
        patch :update, params: { id: @group.id, group: group_params }
        expect(response).to redirect_to '/login'
      end
    end
  end

  # describe '#destroy' do
  #   context 'as an authorized user' do
  #     before do
  #       session[:user_id] = @user.id
  #     end
  #     it 'deletes an article' do
  #       expect do
  #         delete :destroy, params: { id: @group.id }
  #       end.to change(Group.all, :count).by(-1)
  #     end
  #     it 'redirects the page to root_path' do
  #       delete :destroy, params: { id: @group.id }
  #       expect(response).to redirect_to root_path
  #     end
  #   end
  #   context "as an unauthorized user" do
  #     before do
  #       session[:user_id] = @another_user.id
  #     end
  #     it "redirects the page to root_path" do
  #       delete :destroy, params: { id: @group.id }
  #       expect(response).to redirect_to root_path
  #     end
  #   end
  #   context 'as a guest user' do
  #     it 'returns a 302 response' do
  #       delete :destroy, params: { id: @group.id }
  #       expect(response).to have_http_status '302'
  #     end
  #     it 'redirects the page to /login' do
  #       delete :destroy, params: { id: @group.id }
  #       expect(response).to redirect_to '/login'
  #     end
  #   end
  # end
end
