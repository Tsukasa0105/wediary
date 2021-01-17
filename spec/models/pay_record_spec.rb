require 'rails_helper'

RSpec.describe PayRecord, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @group = FactoryBot.create(:group)
    @map = FactoryBot.create(:map, user: @user, group: @group)
    @event = FactoryBot.create(:event, user: @user, group: @group, map: @map)
    @pay_record = FactoryBot.create(:pay_record, paied_user_id: @user.id, event: @event)
  end

  it 'has a valid factory of pay_record' do
    expect(@pay_record).to be_valid
  end

  # 精算記録の名前がなければ無効。
  it 'is invalid without name' do
    pay_record = FactoryBot.build(:pay_record, paied_user_id: @user.id, event: @event, name: nil)
    pay_record.valid?
    expect(pay_record.errors[:name]).to include('を入力してください')
  end

  # 精算記録の金額がなければ無効。
  it 'is invalid without name' do
    pay_record = FactoryBot.build(:pay_record, paied_user_id: @user.id, event: @event, amount: nil)
    pay_record.valid?
    expect(pay_record.errors[:amount]).to include('を入力してください')
  end
end
