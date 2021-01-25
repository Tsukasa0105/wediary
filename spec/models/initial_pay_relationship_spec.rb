# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InitialPayRelationship, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @group = FactoryBot.create(:group)
    @map = FactoryBot.create(:map, user: @user, group: @group)
    @event = FactoryBot.create(:event, user: @user, group: @group, map: @map)
    @pay_record = FactoryBot.create(:pay_record, paied_user_id: @user.id, event: @event)
  end

  let(:active) { @pay_record.initial_pay_relationships.build(initial_user_id: @user.id) }
  subject { active }

  # リレーションシップが有効であること
  it { should be_valid }

  describe 'pay_relationship methods' do
    it { should respond_to(:initial_user) }
    it { should respond_to(:pay_record) }
    # 精算者を返す
    it 'return initial_pay-user' do
      expect(active.initial_user).to eq @user
    end
    # 精算記録を返す
    it 'return (initial)pay-record' do
      expect(active.pay_record).to eq @pay_record
    end
  end

  # validations
  describe 'validations' do
    # 存在性 presence
    describe 'presence' do
      it { is_expected.to validate_presence_of(:initial_user_id) }
      it { is_expected.to validate_presence_of(:pay_record_id) }
    end
  end
end
