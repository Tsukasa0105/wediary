require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:another_user)
  end
  
  # userのfactory_botが有効かどうかを検査。
  it "has a valid factory of user" do
    expect(@user).to be_valid
  end
  it "has a valid factory of another_user" do
    expect(@another_user).to be_valid
  end

  it "名がない場合、無効である" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it "メールアドレスがない場合、無効である"  do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "重複したメールアドレスの場合、無効である" do
    user2 = FactoryBot.build(:user)
    user2.valid?
    expect(user2.errors[:email]).to include("はすでに存在します")
  end

  it "パスワードがない場合、無効である" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it "パスワードが5文字以下の場合、無効である" do
    user = FactoryBot.build(:short_password_user)
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上で入力してください")
  end  
  
  it "パスワードが確認と一致しない場合、無効である" do
    user = FactoryBot.build(:password_unmatch_user)
    user.valid?
    expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
  end  
end