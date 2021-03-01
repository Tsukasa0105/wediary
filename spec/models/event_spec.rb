# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
    @user = FactoryBot.create(:user)
    # @another_user = FactoryBot.create(:another_user)
    @group = FactoryBot.create(:group)
    @map = FactoryBot.create(:map, user: @user, group: @group)
    @event = FactoryBot.create(:event, user: @user, group: @group, map: @map)
  end

  it 'has a valid factory of event' do
    expect(@event).to be_valid
  end

  it 'is invalid without name' do
    event = FactoryBot.build(:event, user: @user, group: @group, map: @map, name: nil)
    event.valid?
    expect(event.errors[:name]).to include('を入力してください')
  end

  it 'is invalid without start_time' do
    event = FactoryBot.build(:event, user: @user, group: @group, map: @map, start_time: nil)
    event.valid?
    expect(event.errors[:start_time]).to include('を入力してください')
  end
  
  it 'is invalid with name more than 20 characters' do
    event = FactoryBot.build(:longnameevent)
    event.valid?
    expect(event.errors[:name]).to include('は20文字以内で入力してください')
  end
end
