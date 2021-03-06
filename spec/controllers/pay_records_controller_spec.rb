
require 'rails_helper'

RSpec.describe PayRecordsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:another_user)
    @group = FactoryBot.create(:group)
    @user.member(@group)
    @group.permit_member(@user)
    @map = FactoryBot.create(:map, user: @user, group: @group)
    @event = FactoryBot.create(:event, user: @user, group: @group, map: @map)
    @pay_record = FactoryBot.create(:pay_record, paied_user_id: @user.id, event: @event)
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
          pay_record: {
            name: 'pay_record1',
            amount: 10_000,
            paied_user_id: @user.id,
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
      it 'does not add a new pay_record' do
        expect {
          post :create, params: {
            group_id: @group.id,
            event_id: @event.id,
            pay_record: {
              name: nil,
              amount: 10_000,
              paied_user_id: @user.id,
              event_id: @event.id
            }
          }
        }.to_not change(PayRecord.all, :count)
      end
      it 'redirects the page to pay_records/new' do
        post :create, params: {
          group_id: @group.id,
          event_id: @event.id,
          pay_record: {
            name: nil,
            amount: 10_000,
            paied_user_id: @user.id,
            event_id: @event.id
          }
        }
        expect(response).to render_template :new
      end
    end
    context 'as an unauthorized user' do
      before do
        session[:user_id] = @another_user.id
      end
      it 'redirects the page to new' do
        post :create, params: {
          group_id: @group.id,
          event_id: @event.id,
          pay_record: {
            name: "pay",
            amount: 10_000,
            paied_user_id: @user.id,
            event_id: @event.id
          }
        }
        expect(response).to render_template :new
      end
    end
    context 'as a guest user' do
      it 'returns a 302 request' do
        get :create, params: { group_id: @group.id, event_id: @event.id }
        expect(response).to have_http_status '302'
      end
      it 'redirects the page to /login' do
        get :create, params: { group_id: @group.id, event_id: @event.id }
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe "#destroy" do
    context "as an authorized user" do
      before do
        session[:user_id] = @user.id
      end
      it "deletes an pay_record" do
        expect {
          delete :destroy, xhr: true, params: {group_id: @group.id, event_id: @event.id, id: @pay_record.id}
        }.to change(PayRecord.all, :count).by(-1)
      end
    end
    context "as an unauthorized user" do
      before do
        session[:user_id] = @another_user.id
      end
      it "redirects the page to root_path" do
        delete :destroy, xhr: true, params: {group_id: @group.id, event_id: @event.id, id: @pay_record.id}
        expect(response).to redirect_to root_path
      end
    end
    context "as a guest user" do
      it "returns a 302 response" do
        delete :destroy, xhr: true, params: {group_id: @group.id, event_id: @event.id, id: @pay_record.id}
        expect(response).to have_http_status "302"
      end
      it "redirects the page to /login" do
        delete :destroy, xhr: true, params: {group_id: @group.id, event_id: @event.id, id: @pay_record.id}
        expect(response).to redirect_to "/login"
      end
    end
  end
end
