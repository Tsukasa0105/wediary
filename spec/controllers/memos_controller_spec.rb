# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MemosController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:another_user)
    @group = FactoryBot.create(:group)
    @user.member(@group)
    @group.permit_member(@user)
    @map = FactoryBot.create(:map, user: @user, group: @group)
    @event = FactoryBot.create(:event, user: @user, group: @group, map: @map)
    @memo = FactoryBot.create(:memo, user_id: @user.id, event: @event)
  end

  describe '#new' do
    context 'as an authorized user' do
      before do
        session[:user_id] = @user.id
      end
      it 'responds successfully' do
        get :new, params: { group_id: @group.id, event_id: @event.id }
        expect(response).to be_success
      end
      it 'returns a 200 response' do
        get :new, params: { group_id: @group.id, event_id: @event.id }
        expect(response).to have_http_status '200'
      end
    end
    context 'as a guest user' do
      it 'does not respond successfully' do
        get :new, params: { group_id: @group.id, event_id: @event.id }
        expect(response).to_not be_success
      end
      it 'returns a 302 response' do
        get :new, params: { group_id: @group.id, event_id: @event.id }
        expect(response).to have_http_status '302'
      end
      it 'redirects the page to /login' do
        get :new, params: { group_id: @group.id, event_id: @event.id }
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe '#create' do
    context 'as an authorized user' do
      before do
        session[:user_id] = @user.id
      end
      it 'redirects the page to event/show' do
        post :create, params: {
          group_id: @group.id,
          event_id: @event.id,
          memo: {
            title: 'memo1',
            content: 'memo1',
            user_id: @user.id,
            event_id: @event.id
          }
        }
        expect(response).to redirect_to group_event_path(@group, @event)
      end
    end
    context 'with invalid attributes' do
      before do
        session[:user_id] = @user.id
      end
      it 'does not add a new memo' do
        expect {
          post :create, params: {
            group_id: @group.id,
            event_id: @event.id,
            memo: { title: nil, content: 'memo3', user_id: @user.id, event_id: @event.id }
          }
        }.to_not change(Memo.all, :count)
      end
      it 'redirects the page to memos/new' do
        post :create, params: {
          group_id: @group.id,
          event_id: @event.id,
          memo: { title: nil, content: 'memo3', user_id: @user.id, event_id: @event.id }
        }
        expect(response).to render_template :new
      end
    end
    context 'as an unauthorized user' do
      before do
        session[:user_id] = @another_user.id
      end
      it 'redirects the page to /groups/group.id/events/event,id/memos/new' do
        post :create, params: {
          group_id: @group.id,
          event_id: @event.id,
          memo: { title: 'memo4', content: 'memo3', user_id: @user.id, event_id: @event.id }
        }
        expect(response).to render_template :new
      end
    end
    context 'as a guest user' do
      it 'returns a 302 request' do
        get :create, params: { title: 'invilidmemo', group_id: @group.id, event_id: @event.id }
        expect(response).to have_http_status '302'
      end
      it 'redirects the page to /login' do
        get :create, params: { title: 'invilidmemo', group_id: @group.id, event_id: @event.id }
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe '#destroy' do
    context 'as an authorized user' do
      before do
        session[:user_id] = @user.id
      end
      it 'deletes an memo' do
        expect do
          delete :destroy, params: { group_id: @group.id, event_id: @event.id, id: @memo.id }, xhr: true
        end.to change(Memo.all, :count).by(-1)
      end
    end
    context "as an unauthorized user" do
      before do
        session[:user_id] = @another_user.id
      end
      it "redirects the page to root_path" do
        delete :destroy, params: {group_id: @group.id, event_id: @event.id, id: @memo.id}
        expect(response).to redirect_to root_path
      end
    end
    context 'as a guest user' do
      it 'returns a 302 response' do
        delete :destroy, params: { group_id: @group.id, event_id: @event.id, id: @memo.id }
        expect(response).to have_http_status '302'
      end
      it 'redirects the page to /login' do
        delete :destroy, params: { group_id: @group.id, event_id: @event.id, id: @memo.id }
        expect(response).to redirect_to '/login'
      end
    end
  end
end
