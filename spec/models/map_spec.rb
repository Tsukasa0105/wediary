require 'rails_helper'

RSpec.describe Map, type: :model do
  before do
    @user = FactoryBot.create(:user)
    # @another_user = FactoryBot.create(:another_user)
    @group = FactoryBot.create(:group)
    @map = FactoryBot.create(:map, user: @user, group: @group)
  end

  it "has a valid factory of map" do
    expect(@map).to be_valid
  end

  # マップの名前がなければ無効。
  it "is invalid without title" do
    map = FactoryBot.build(:map, user: @user, group: @group, title: nil)
    map.valid?
    expect(map.errors[:title]).to include("を入力してください")
  end
  
  # マップの緯度がなければ無効。
  it "is invalid without latitude" do
    map = FactoryBot.build(:map, user: @user, group: @group, latitude: nil)
    map.valid?
    expect(map.errors[:latitude]).to include("を入力してください")
  end
  
  # マップの経度がなければ無効。
  it "is invalid without longitude" do
    map = FactoryBot.build(:map, user: @user, group: @group, longitude: nil)
    map.valid?
    expect(map.errors[:longitude]).to include("を入力してください")
  end
end
