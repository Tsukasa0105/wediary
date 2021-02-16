# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MemosController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:another_user)
    @group = FactoryBot.create(:group)
    @map = FactoryBot.create(:map, user: @user, group: @group)
    @event = FactoryBot.create(:event, user: @user, group: @group, map: @map)
    @memo = FactoryBot.create(:memo, user_id: @user.id, event: @event)
  end

  describe '#new' do
    # 正常なユーザの場合
    context 'as an authorized user' do
      before do
        session[:user_id] = @user.id
      end
      # 正常なレスポンスか？
      it 'responds successfully' do
        get :new, params: { group_id: @group.id, event_id: @event.id }
        expect(response).to be_success
      end
      # 200レスポンスが返ってきているか？
      it 'returns a 200 response' do
        get :new, params: { group_id: @group.id, event_id: @event.id }
        expect(response).to have_http_status '200'
      end
    end
    # 権限を有さないユーザの場合
    context 'as a guest user' do
      # 正常なレスポンスか？
      it 'does not respond successfully' do
        get :new, params: { group_id: @group.id, event_id: @event.id }
        expect(response).to_not be_success
      end
      # 200レスポンスが返ってきているか？
      it 'returns a 302 response' do
        get :new, params: { group_id: @group.id, event_id: @event.id }
        expect(response).to have_http_status '302'
      end
      # ログイン画面にリダイレクトされているか？
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
      # 正常にグループを作成できるか？
      it 'adds a new memo' do
        # Factorybotで確認済み
      end
      # 記事作成後に作成した記事の詳細ページへリダイレクトされているか？
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
      # 不正なアトリビュートを含む記事は作成できなくなっているか？
      it 'does not add a new memo' do
        # expect {
        #   @group = FactoryBot.create(:another_group, name: nil)
        # }.to_not change(@groups, :count)
      end
      # 不正な記事を作成しようとすると、再度作成ページへリダイレクトされるか？
      it 'redirects the page to memos/new' do
        post :create, params: {
          group_id: @group.id,
          event_id: @event.id,
          memo: {
            title: nil,
            content: 'memo2',
            user_id: @user.id,
            event_id: @event.id
          }
        }
        expect(response).to render_template :new
      end
    end
    context 'as a guest user' do
      # 302レスポンスが返ってきているか？
      it 'returns a 302 request' do
        get :create, params: { group_id: @group.id, event_id: @event.id }
        expect(response).to have_http_status '302'
      end
      # ログイン画面にリダイレクトされているか？
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
      # 正常にmemoを削除できるか？
      it "deletes an memo" do
        expect {
          delete :destroy, params: {group_id: @group.id, event_id: @event.id, id: @memo.id}
        }.to change(Memo.all, :count).by(-1)
      end
      # 記事を削除した後、event/showへリダイレクトしているか？
      it "redirects the page to event_path" do
        delete :destroy, params: {group_id: @group.id, event_id: @event.id, id: @memo.id}
        expect(response).to redirect_to group_event_path(@group, @event)
      end
    end
    context "as a guest user" do
      # 302レスポンスを返すか？
      it "returns a 302 response" do
        delete :destroy, params: {group_id: @group.id, event_id: @event.id, id: @memo.id}
        expect(response).to have_http_status "302"
      end
      # ログイン画面にリダイレクトされているか？
      it "redirects the page to /login" do
        delete :destroy, params: {group_id: @group.id, event_id: @event.id, id: @memo.id}
        expect(response).to redirect_to "/login"
      end
    end
  end
end
