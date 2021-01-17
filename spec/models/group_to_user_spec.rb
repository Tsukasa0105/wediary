require 'rails_helper'

RSpec.describe GroupToUser, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @group = FactoryBot.create(:group)
  end

  let(:active) { @group.group_to_users.build(invited_user_id: @user.id) }
  subject { active }

  # リレーションシップが有効であること
  it { should be_valid }

  describe 'group_to_user methods' do
    it { should respond_to(:invited_user) }
    it { should respond_to(:inviting_group) }
    # 招待メソッドは、招待しているユーザを返すこと
    it 'inviting method return inviting-user' do
      expect(active.invited_user).to eq @user
    end
    # 招待許可メソッドは、許可するグループを返すこと
    it 'permit method return permit-group' do
      expect(active.inviting_group).to eq @group
    end
  end

  # validations
  # describe "validations" do
  #   # 存在性 presence
  #   describe "presence" do
  #     it { is_expected.to validate_presence_of(:invited_user_id) }
  #     it { is_expected.to validate_presence_of(:inviting_group_id) }
  #   end
  # end
end
