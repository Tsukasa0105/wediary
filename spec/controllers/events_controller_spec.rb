# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:another_user)
    @group = FactoryBot.create(:group)
    @user.member(@group)
    @group.permit_member(@user)
    @map = FactoryBot.create(:map, user: @user, group: @group)
    @event = FactoryBot.create(:event, user: @user, group: @group, map: @map)
  end

  describe '#show' do
    context 'as an authorized user' do
      before do
        session[:user_id] = @user.id
      end
      # 正常なレスポンスか？
      it 'responds successfully' do
        get :show, params: { group_id: @group.id, id: @event.id }
        expect(response).to be_success
      end
      # 200レスポンスが返ってきているか？
      it 'returns a 200 response' do
        get :show, params: { group_id: @group.id, id: @event.id }
        expect(response).to have_http_status '200'
      end
    end
    context 'as a guest user' do
      it 'does not respond successfully' do
        get :show, params: { group_id: @group.id, id: @event.id }
        expect(response).to_not be_success
      end
      it 'returns a 302 response' do
        get :show, params: { group_id: @group.id, id: @event.id }
        expect(response).to have_http_status '302'
      end
      it 'redirects the page to /login' do
        get :show, params: { group_id: @group.id, id: @event.id }
        expect(response).to redirect_to login_path
      end
    end
  end

  describe '#new' do
    context 'as an authorized user' do
      before do
        session[:user_id] = @user.id
      end
      it 'responds successfully' do
        get :new, params: { group_id: @group.id }
        expect(response).to be_success
      end
      it 'returns a 200 response' do
        get :new, params: { group_id: @group.id }
        expect(response).to have_http_status '200'
      end
    end
    context 'as a guest user' do
      it 'does not respond successfully' do
        get :new, params: { group_id: @group.id }
        expect(response).to_not be_success
      end
      it 'returns a 302 response' do
        get :new, params: { group_id: @group.id }
        expect(response).to have_http_status '302'
      end
      it 'redirects the page to /login' do
        get :new, params: { group_id: @group.id }
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
          event: { name: 'event1', user_id: @user.id, group_id: @group.id, map_id: @map.id, start_time: Time.now }
        }
        event = Event.last
        expect(response).to redirect_to group_event_path(event.group, event)
      end
    end
    context 'with invalid attributes' do
      before do
        session[:user_id] = @another_user.id
      end
      it 'renders events/new' do
        post :create, params: {
          group_id: @group.id,
          event: {
            name: nil
          }
        }
        expect(response).to render_template 'events/new'
      end
    end
    context 'as an unauthorized user' do
      before do
        session[:user_id] = @another_user.id
      end
      it 'redirects the page to /groups/group.id/events/new' do
        post :create, params: {
          group_id: @group.id,
          event: { name: 'event2', user_id: @another_user.id, group_id: @group.id, map_id: @map.id, start_time: Time.now }
        }
        expect(response).to render_template :new
      end
    end
    context 'as a guest user' do
      it 'returns a 302 request' do
        get :create, params: { group_id: @group.id }
        expect(response).to have_http_status '302'
      end
      it 'redirects the page to /login' do
        get :create, params: { group_id: @group.id }
        expect(response).to redirect_to '/login'
      end
    end
  end

    describe "#edit" do
      context "as an authorized user" do
        before do
          session[:user_id] = @user.id
        end
        it "responds successfully" do
          get :edit, params: {group_id: @group.id, id: @event.id}
          expect(response).to be_success
        end
        it "returns a 200 response" do
          get :edit, params: {group_id: @group.id, id: @event.id}
          expect(response).to have_http_status "200"
        end
      end
      context "as a guest user" do
        it "returns a 302 response" do
          get :edit, params: {group_id: @group.id, id: @event.id}
          expect(response).to have_http_status "302"
        end
        # ログイン画面にリダイレクトされているか？
        it "redirects the page to /login" do
          get :edit, params: {group_id: @group.id, id: @event.id}
          expect(response).to redirect_to "/login"
        end
      end
    end

    describe "#update" do
      context "as an authorized user" do
        before do
          session[:user_id] = @user.id
        end
        it "updates an event" do
          event_params = {name: "event2"}
          patch :update, params: {group_id: @group.id, id: @event.id, event: event_params}
          expect(@event.reload.name).to eq "event2"
        end
        it "redirects the page to /" do
          event_params = {name: "name2"}
          patch :update, params: {group_id: @group.id, id: @event.id, event: event_params}
          expect(response).to redirect_to "/groups/#{@group.id}/events/#{@event.id}"
        end
      end
      context "with invalid attributes" do
        before do
          session[:user_id] = @user.id
        end
        it "does not update an event" do
          event_params = {name: nil}
          patch :update, params: {group_id: @group.id, id: @event.id, event: event_params}
          expect(@event.reload.name).to eq "event"
        end
        it "redirects the page to /groups/group.id/events/event.id/edit" do
          event_params = {name: nil}
          patch :update, params: {group_id: @group.id, id: @event.id, event: event_params}
          expect(response).to render_template :edit
        end
      end
      context "as an unauthorized user" do
        before do
          session[:user_id] = @another_user.id
        end
        it "does not update an event" do
          event_params = {name: "event3"}
          patch :update, params: {group_id: @group.id, id: @event.id, event: event_params}
          expect(@event.reload.name).to eq "event"
        end
        it "redirects the page to /groups/group.id/events/event.id/edit" do
          event_params = {name: "event4"}
          patch :update, params: {group_id: @group.id, id: @event.id, event: event_params}
          expect(response).to render_template :edit
        end
      end
      context "as a guest user" do
        it "returns a 302 response" do
          event_params = {name: nil}
          patch :update, params: {group_id: @group.id, id: @event.id, event: event_params}
          expect(response).to have_http_status "302"
        end
        it "redirects the page to /users/login" do
          event_params = {name: nil}
          patch :update, params: {group_id: @group.id, id: @event.id, event: event_params}
          expect(response).to redirect_to "/login"
        end
      end
    end

    describe "#destroy" do
      context "as an authorized user" do
        before do
          session[:user_id] = @user.id
        end
        it "deletes an event" do
          expect {
            delete :destroy, params: {group_id: @group.id, id: @event.id}
          }.to change(Event.all, :count).by(-1)
        end
        it "redirects the page to /groups/group.id" do
          delete :destroy, params: {group_id: @group.id, id: @event.id}
          expect(response).to redirect_to "/groups/#{@group.id}"
        end
      end
      context "as an unauthorized user" do
        before do
          session[:user_id] = @another_user.id
        end
        it "redirects the page to root_path" do
          delete :destroy, params: {group_id: @group.id, id: @event.id}
          expect(response).to redirect_to root_path
        end
      end
      context "as a guest user" do
        it "returns a 302 response" do
          delete :destroy, params: {group_id: @group.id, id: @event.id}
          expect(response).to have_http_status "302"
        end
        it "redirects the page to /login" do
          delete :destroy, params: {group_id: @group.id, id: @event.id}
          expect(response).to redirect_to "/login"
        end
      end
    end
end
