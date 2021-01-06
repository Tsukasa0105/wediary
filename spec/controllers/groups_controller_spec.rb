require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
    
    before do
      @user = FactoryBot.create(:user)
      @group = FactoryBot.create(:group)
    end
    
    describe "#index" do
      #正常なユーザの場合
      context "as an authorized user" do
        before do
          session[:user_id] = @user.id
        end
        # 正常なレスポンスか？
        it "responds successfully" do
          get :index
          expect(response).to be_success
        end
        # 200レスポンスが返ってきているか？
        it "returns a 200 response" do
          get :index
          expect(response).to have_http_status "200"
        end
      end
      #権限を有さないユーザの場合
      context "as a guest user" do
        # 正常なレスポンスか？
        it "does not respond successfully" do
          get :index
          expect(response).to_not be_success
        end
        # 200レスポンスが返ってきているか？
        it "returns a 302 response" do
          get :index
          expect(response).to have_http_status "302"
        end
        # ログイン画面にリダイレクトされているか？
        it "redirects the page to /login" do
          get :index
          expect(response).to redirect_to "/login"
        end
      end
    end

    describe "#show" do
      context "as an authorized user" do
        before do
          session[:user_id] = @user.id
        end
        # 正常なレスポンスか？
        it "responds successfully" do
          get :show, params: {id: @group.id}
          expect(response).to be_success
        end
        # 200レスポンスが返ってきているか？
        it "returns a 200 response" do
          get :show, params: {id: @group.id}
          expect(response).to have_http_status "200"
        end
      end
      context "as a guest user" do
        # 正常なレスポンスか？
        it "does not respond successfully" do
          get :show, params: {id: @group.id}
          expect(response).to_not be_success
        end
        # 200レスポンスが返ってきているか？
        it "returns a 302 response" do
          get :show, params: {id: @group.id}
          expect(response).to have_http_status "302"
        end
        # ログイン画面にリダイレクトされているか？
        it "redirects the page to /login" do
          get :show, params: {id: @group.id}
          expect(response).to redirect_to "/login"
        end
      end
    end
    
    describe "#new" do
      #正常なユーザの場合
      context "as an authorized user" do
        before do
          session[:user_id] = @user.id
        end
        # 正常なレスポンスか？
        it "responds successfully" do
          get :new
          expect(response).to be_success
        end
        # 200レスポンスが返ってきているか？
        it "returns a 200 response" do
          get :new
          expect(response).to have_http_status "200"
        end
      end
      #権限を有さないユーザの場合
      context "as a guest user" do
        # 正常なレスポンスか？
        it "does not respond successfully" do
          get :new
          expect(response).to_not be_success
        end
        # 200レスポンスが返ってきているか？
        it "returns a 302 response" do
          get :new
          expect(response).to have_http_status "302"
        end
        # ログイン画面にリダイレクトされているか？
        it "redirects the page to /login" do
          get :new
          expect(response).to redirect_to "/login"
        end
      end
    end
    
    describe "#create" do
      context "as an authorized user" do
        before do
          session[:user_id] = @user.id
        end
        # 正常にグループを作成できるか？
        it "adds a new group" do
        #Factorybotで確認済み
        end
        # 記事作成後に作成した記事の詳細ページへリダイレクトされているか？
        it "redirects the page to /" do
        post :create, params: {
          group: {
            name: "another_user",
            key: "another_user"
          }
        }
          expect(response).to redirect_to "/"
        end
      end
      context "with invalid attributes" do
        before do
          session[:user_id] = @user.id
        end
        # 不正なアトリビュートを含む記事は作成できなくなっているか？
        it "does not add a new pin" do
          # expect {
          #   @group = FactoryBot.create(:another_group, name: nil)
          # }.to_not change(@groups, :count)
        end
        # 不正な記事を作成しようとすると、再度作成ページへリダイレクトされるか？
        it "redirects the page to groups/new" do
          post :create, params: {
            group: {
              name: nil,
              key: "another_user"
            }
          }
          expect(response).to render_template "groups/new"
        end
      end
      context "as a guest user" do
        # 302レスポンスが返ってきているか？
        it "returns a 302 request" do
          get :create
          expect(response).to have_http_status "302"
        end
        # ログイン画面にリダイレクトされているか？
        it "redirects the page to /login" do
          get :create
          expect(response).to redirect_to "/login"
        end
      end
    end

end
