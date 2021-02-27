# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Memo, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @group = FactoryBot.create(:group)
    @map = FactoryBot.create(:map, user: @user, group: @group)
    @event = FactoryBot.create(:event, user: @user, group: @group, map: @map)
    @memo = FactoryBot.create(:memo, user_id: @user.id, event: @event)
  end

  it 'has a valid factory of pay_record' do
    expect(@memo).to be_valid
  end

  # memoの名前がなければ無効。
  it 'is invalid without title' do
    memo = FactoryBot.build(:memo, user_id: @user.id, event: @event, title: nil)
    memo.valid?
    expect(memo.errors[:title]).to include('を入力してください')
  end
end
