require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    
    before do
      @user = FactoryBot.create(:user)
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
          get :show, params: {id: @user.id}
          expect(response).to be_success
        end
        # 200レスポンスが返ってきているか？
        it "returns a 200 response" do
          get :show, params: {id: @user.id}
          expect(response).to have_http_status "200"
        end
      end
      context "as a guest user" do
        # 正常なレスポンスか？
        it "does not respond successfully" do
          get :show, params: {id: @user.id}
          expect(response).to_not be_success
        end
        # 200レスポンスが返ってきているか？
        it "returns a 302 response" do
          get :show, params: {id: @user.id}
          expect(response).to have_http_status "302"
        end
        # ログイン画面にリダイレクトされているか？
        it "redirects the page to /login" do
          get :show, params: {id: @user.id}
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
    end
    
    describe "#create" do
      context "as an authorized user" do
        # 正常にユーザを作成できるか？
        it "adds a new user" do
        #Factorybotで確認済み
        end
        # 記事作成後に作成した記事の詳細ページへリダイレクトされているか？
        it "redirects the page to /" do
          post :create, params: {
            user: {
              name: "user1",
              email: "user1@gmail.com",
              password: "user1user1",
              password_confirmation: "user1user1"
            }
          }
          expect(response).to redirect_to "/"
        end
        # 不正なアトリビュートを含む記事は作成できなくなっているか？
        it "does not add a new user" do
          # expect {
          #   @group = FactoryBot.create(:another_group, name: nil)
          # }.to_not change(@groups, :count)
        end
        # 不正なユーザを作成しようとすると、再度作成ページへリダイレクトされるか？
        it "redirects the page to groups/new" do
          post :create, params: {
            user: {
              name: nil
            }
          }
          expect(response).to render_template "users/new"
        end
      end
    end
    
  describe "#edit" do
    context "as an authorized user" do
      before do
        session[:user_id] = @user.id
      end
      # 正常なレスポンスか？
      it "responds successfully" do
        get :edit, params: {id: @user.id}
        expect(response).to be_success
      end
      # 200レスポンスが返ってきているか？
      it "returns a 200 response" do
        get :edit, params: {id: @user.id}
        expect(response).to have_http_status "200"
      end
    end
    context "as an unauthorized user" do
      # 正常なレスポンスが返ってきていないか？
      it "does not respond successfully" do
        get :edit, params: {id: @user.id}
        expect(response).to_not be_success
      end
      # 他のユーザーがユーザを編集しようとすると、ルートページへリダイレクトされているか？
      it "redirects the page to root_path" do
        # sign_in @another_user
        # get :edit, params: {id: @user.id}
        # expect(response).to redirect_to root_path
      end
    end
    context "as a guest user" do
      # 302レスポンスが返ってきているか？
      it "returns a 302 response" do
        get :edit, params: {id: @user.id}
        expect(response).to have_http_status "302"
      end
      # ログイン画面にリダイレクトされているか？
      it "redirects the page to /login" do
        get :edit, params: {id: @user.id}
        expect(response).to redirect_to "/login"
      end
    end
  end
  
  describe "#update" do
    context "as an authorized user" do
      before do
        session[:user_id] = @user.id
      end
      # 正常に記事を更新できるか？
      it "updates an user" do
        user_params = {name: "user2"}
        patch :update, params: {id: @user.id, user: user_params}
        expect(@user.reload.name).to eq "user2"
      end
      # 記事を更新した後、更新された記事の詳細ページへリダイレクトするか？
      it "redirects the page to /" do
        user_params = {name: "user2"}
        patch :update, params: {id: @user.id, user: user_params}
        expect(response).to redirect_to "/"
      end
    end
    context "with invalid attributes" do
      before do
        session[:user_id] = @user.id
      end
      # 不正なアトリビュートを含むグループは更新できなくなっているか？
      it "does not update an user" do
        user_params = {name: nil}
        patch :update, params: {id: @user.id, user: user_params}
        expect(@user.reload.name).to eq "user"
      end
      # 不正な記事を更新しようとすると、再度更新ページへリダイレクトされるか？
      it "redirects the page to /users/@user.id/edit" do
        user_params = {name: nil}
        patch :update, params: {id: @user.id, user: user_params}
        expect(response).to render_template :edit
      end
    end
    context "as an unauthorized user" do
      # 正常なレスポンスが返ってきていないか？
      it "does not respond successfully" do
        get :edit, params: {id: @user.id}
        expect(response).to_not be_success
      end
      # 他のユーザーが記事を編集しようとすると、ルートページへリダイレクトされているか？
      it "redirects the page to root_path" do
        # sign_in @another_user
        # get :edit, params: {id: @article.id}
        # expect(response).to redirect_to root_path
      end
    end
    context "as a guest user" do
      # 302レスポンスを返すか？
      it "returns a 302 response" do
        user_params = {name: "user2"}
        patch :update, params: {id: @user.id, user: user_params}
        expect(response).to have_http_status "302"
      end
      # ログイン画面にリダイレクトされているか？
      it "redirects the page to /users/login" do
        user_params = {name: "user2"}
        patch :update, params: {id: @user.id, user: user_params}
        expect(response).to redirect_to "/login"
      end
    end
  end

#   describe "#destroy" do
#     context "as an authorized user" do
#       before do
#         session[:user_id] = @user.id
#       end
#       # 正常に記事を削除できるか？
#       it "deletes an user" do
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
