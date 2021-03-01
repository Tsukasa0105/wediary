# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:another_user)
    @group = FactoryBot.create(:group)
    @user.member(@group)
    @group.permit_member(@user)
    @map = FactoryBot.create(:map, user: @user, group: @group)
    @event = FactoryBot.create(:event, user: @user, group: @group, map: @map)
    @notification = FactoryBot.create(:notification)
  end

  it 'has a valid factory of group' do
    expect(@notification).to be_valid
  end

  it 'is valid with name, key' do
    @notification.valid?
    expect(@notification).to be_valid
  end
end
