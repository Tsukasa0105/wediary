# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:another_user)
  end

  let(:active) { @user.relationships.build(follow_id: @another_user.id) }
  subject { active }

  # リレーションシップが有効であること
  it { should be_valid }

  # follow/followedメソッド
  describe 'follower/followed methods' do
    it { should respond_to(:user) }
    it { should respond_to(:follow) }
    # followメソッドは、フォローしているユーザを返すこと
    it 'follower method return following-user' do
      expect(active.user).to eq @user
    end
    # followerメソッドは、フォローされているユーザを返すこと
    it 'followed method return followed-user' do
      expect(active.follow).to eq @another_user
    end
  end

  # validations
  describe 'validations' do
    # 存在性 presence
    describe 'presence' do
      it { is_expected.to validate_presence_of(:user_id) }
      it { is_expected.to validate_presence_of(:follow_id) }
    end
  end
end
