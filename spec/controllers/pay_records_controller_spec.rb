# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PayRecordsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @group = FactoryBot.create(:group)
    @map = FactoryBot.create(:map, user: @user, group: @group)
    @event = FactoryBot.create(:event, user: @user, group: @group, map: @map)
    @pay_record = FactoryBot.create(:pay_record, paied_user_id: @user.id, event: @event)
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
      it 'adds a new pay_record' do
        # Factorybotで確認済み
      end
      # 記事作成後に作成した記事の詳細ページへリダイレクトされているか？
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
      # 不正なアトリビュートを含む記事は作成できなくなっているか？
      it 'does not add a new pay_record' do
        # expect {
        #   @group = FactoryBot.create(:another_group, name: nil)
        # }.to_not change(@groups, :count)
      end
      # 不正な記事を作成しようとすると、再度作成ページへリダイレクトされるか？
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

  #   describe "#edit" do
  #     context "as an authorized user" do
  #       before do
  #         session[:user_id] = @user.id
  #       end
  #       # 正常なレスポンスか？
  #       it "responds successfully" do
  #         get :edit, params: {id: @group.id}
  #         expect(response).to be_success
  #       end
  #       # 200レスポンスが返ってきているか？
  #       it "returns a 200 response" do
  #         get :edit, params: {id: @group.id}
  #         expect(response).to have_http_status "200"
  #       end
  #     end
  #     context "as an unauthorized user" do
  #       # 正常なレスポンスが返ってきていないか？
  #       it "does not respond successfully" do
  #         get :edit, params: {id: @group.id}
  #         expect(response).to_not be_success
  #       end
  #       # 他のユーザーが記事を編集しようとすると、ルートページへリダイレクトされているか？
  #       it "redirects the page to root_path" do
  #         # sign_in @another_user
  #         # get :edit, params: {id: @article.id}
  #         # expect(response).to redirect_to root_path
  #       end
  #     end
  #     context "as a guest user" do
  #       # 302レスポンスが返ってきているか？
  #       it "returns a 302 response" do
  #         get :edit, params: {id: @group.id}
  #         expect(response).to have_http_status "302"
  #       end
  #       # ログイン画面にリダイレクトされているか？
  #       it "redirects the page to /login" do
  #         get :edit, params: {id: @group.id}
  #         expect(response).to redirect_to "/login"
  #       end
  #     end
  #   end

  #   describe "#update" do
  #     context "as an authorized user" do
  #       before do
  #         session[:user_id] = @user.id
  #       end
  #       # 正常に記事を更新できるか？
  #       it "updates an group" do
  #         group_params = {name: "group2"}
  #         patch :update, params: {id: @group.id, group: group_params}
  #         expect(@group.reload.name).to eq "group2"
  #       end
  #       # 記事を更新した後、更新された記事の詳細ページへリダイレクトするか？
  #       it "redirects the page to /" do
  #         group_params = {name: "name2"}
  #         patch :update, params: {id: @group.id, group: group_params}
  #         expect(response).to redirect_to "/groups/#{@group.id}"
  #       end
  #     end
  #     context "with invalid attributes" do
  #       before do
  #         session[:user_id] = @user.id
  #       end
  #       # 不正なアトリビュートを含むグループは更新できなくなっているか？
  #       it "does not update an group" do
  #         group_params = {name: nil}
  #         patch :update, params: {id: @group.id, group: group_params}
  #         expect(@group.reload.name).to eq "group"
  #       end
  #       # 不正な記事を更新しようとすると、再度更新ページへリダイレクトされるか？
  #       it "redirects the page to /groups/group.id(1)/edit" do
  #         group_params = {name: nil}
  #         patch :update, params: {id: @group.id, group: group_params}
  #         expect(response).to render_template :edit
  #       end
  #     end
  #     context "as an unauthorized user" do
  #       # 正常なレスポンスが返ってきていないか？
  #       it "does not respond successfully" do
  #         get :edit, params: {id: @group.id}
  #         expect(response).to_not be_success
  #       end
  #       # 他のユーザーが記事を編集しようとすると、ルートページへリダイレクトされているか？
  #       it "redirects the page to root_path" do
  #         # sign_in @another_user
  #         # get :edit, params: {id: @article.id}
  #         # expect(response).to redirect_to root_path
  #       end
  #     end
  #     context "as a guest user" do
  #       # 302レスポンスを返すか？
  #       it "returns a 302 response" do
  #         group_params = {name: "group2"}
  #         patch :update, params: {id: @group.id, group: group_params}
  #         expect(response).to have_http_status "302"
  #       end
  #       # ログイン画面にリダイレクトされているか？
  #       it "redirects the page to /users/login" do
  #         group_params = {name: "group2"}
  #         patch :update, params: {id: @group.id, group: group_params}
  #         expect(response).to redirect_to "/login"
  #       end
  #     end
  #   end

  #   describe "#destroy" do
  #     context "as an authorized user" do
  #       before do
  #         session[:user_id] = @user.id
  #       end
  #       # 正常に記事を削除できるか？
  #       it "deletes an article" do
  #         expect {
  #           delete :destroy, params: {id: @group.id}
  #         }.to change(Group.all, :count).by(-1)
  #       end
  #       # 記事を削除した後、ルートページへリダイレクトしているか？
  #       it "redirects the page to root_path" do
  #         delete :destroy, params: {id: @group.id}
  #         expect(response).to redirect_to root_path
  #       end
  #     end
  #     # context "as an unauthorized user" do
  #     #   # 他のユーザーが記事を削除しようとすると、ルートページへリダイレクトされるか？
  #     #   it "redirects the page to root_path" do
  #     #     sign_in @user
  #     #     another_article = @another_user.articles.create(
  #     #       title: "じゅん？！",
  #     #       text: "南原清隆"
  #     #     )
  #     #     delete :destroy, params: {id: another_article.id}
  #     #     expect(response).to redirect_to root_path
  #     #   end
  #     # end
  #     context "as a guest user" do
  #       # 302レスポンスを返すか？
  #       it "returns a 302 response" do
  #         delete :destroy, params: {id: @group.id}
  #         expect(response).to have_http_status "302"
  #       end
  #       # ログイン画面にリダイレクトされているか？
  #       it "redirects the page to /login" do
  #         delete :destroy, params: {id: @group.id}
  #         expect(response).to redirect_to "/login"
  #       end
  #     end
  #   end
end
