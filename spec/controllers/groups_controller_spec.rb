require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
    
    before do
        @user = FactoryBot.create(:user)
        session[:user_id] = @user.id
        @group = FactoryBot.create(:group)
    end
    
    describe "#index" do
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

    describe "#show" do
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
end
