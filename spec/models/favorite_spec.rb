require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @group = FactoryBot.create(:group)
    @map = FactoryBot.create(:map, user: @user, group: @group)
    @event = FactoryBot.create(:event, user: @user, group: @group, map: @map)
    @memo = FactoryBot.create(:memo, user_id: @user.id, event: @event)
  end

  let(:active) { @memo.favorites.build(user_id: @user.id) }
  subject { active }

  # リレーションシップが有効であること
  it { should be_valid }

  describe 'favorites methods' do
    it { should respond_to(:user) }
    it { should respond_to(:memo) }
    # 招待メソッドは、招待しているユーザを返すこと
    it 'favorite method return user' do
      expect(active.user).to eq @user
    end
    # 招待許可メソッドは、許可するグループを返すこと
    it 'unfavorite method return memo' do
      expect(active.memo).to eq @memo
    end
  end
end
