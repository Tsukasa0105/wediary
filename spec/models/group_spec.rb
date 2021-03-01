# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:another_user)
    @group = FactoryBot.create(:group)
  end

  it 'has a valid factory of group' do
    expect(@group).to be_valid
  end

  it 'is valid with name, key' do
    @group.valid?
    expect(@group).to be_valid
  end

  it 'is invalid without name' do
    group = Group.new(name: nil)
    group.valid?
    expect(group.errors[:name]).to include('を入力してください')
  end

  it 'is invalid without key' do
    group = Group.new(key: nil)
    group.valid?
    expect(group.errors[:key]).to include('を入力してください')
  end

  it 'does allow each user to have an article which has the same title' do
    group = FactoryBot.build(:group)
    group.valid?
    expect(group.errors[:key]).to include('はすでに存在します')
  end
end
