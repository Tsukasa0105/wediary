# frozen_string_literal: true

require 'rails_helper'

feature 'Event', type: :feature do
  feature 'ユーザー登録後', type: :feature do
    background do
      @user = FactoryBot.create(:integration_user)
      @group = FactoryBot.create(:group, invited_user_ids: [@user.id])
      @user.user_to_groups.create(group_id: @group.id)
      @map = FactoryBot.create(:map, user: @user, group: @group)
      @event = FactoryBot.create(:event, user: @user, group: @group, map: @map)
      @another_group = FactoryBot.create(:another_group, invited_user_ids: [@user.id])
      visit login_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      click_on 'ログインする'
    end

    # MapのJavascriptが機能しないのでとりあえず保留
    # scenario 'イベント登録画面遷移→マップ登録できるか' do
    #   visit group_path(@group)
    #   click_on "new_event"
    #   click_on '地図から選ぶ'
    #   fill_in 'address', with: '東京'
    #   click_on '検索'
    #   binding.pry
    #   click_on '保存'
    #   binding.pry
    #   map = Map.last
    #   expect(current_path).to eq new_group_event_path(map.group)
    # end

    scenario 'イベント登録ができるか' do
      visit new_group_event_path(@group)
      fill_in "イベント名", with: "integration_test"
      click_on "保存"
      expect(page).to have_content("イベントを作成しました")
    end

    scenario 'groups/showからevents/showに遷移できるか' do
      visit group_path(@group)
      first('.portfolio-box').click
      expect(current_path).to eq group_event_path(@group, @event)
    end

    scenario 'イベント編集ができるか' do
      visit group_event_path(@group, @event)
      find(".edit_event").click
      fill_in 'イベント名', with: "edit_test"
      click_on '保存'
      expect(current_path).to eq group_event_path(@group, @event)
      expect(page).to have_content("イベントを編集しました")
    end

    # scenario '招待中のグループのメンバーになる' do
    #   click_on "Groups", match: :first
    #   click_on "招待中"
    #   click_on "メンバーになる", match: :first
    #   expect(current_path).to eq search_groups_path
    # end

    # scenario 'group_to_userとuser_to_groupが機能している場合、group_pathからgroups/showに遷移できるか' do
    #   @user.user_to_groups.create(group_id: @group.id)
    #   click_on "Groups", match: :first
    #   find(".portfolio-box").click
    #   expect(current_path).to eq group_path(@group)
    #   expect(page).to have_content(@group.name)
    # end

    # scenario 'groups/editに遷移できるか' do
    #   @user.user_to_groups.create(group_id: @group.id)
    #   click_on "Groups", match: :first
    #   find(".portfolio-box").click
    #   click_on "edit_group"
    #   expect(current_path).to eq edit_group_path(@group)
    # end

    # scenario 'groups/editのフォームは正しい値か' do
    #   @user.user_to_groups.create(group_id: @group.id)
    #   visit edit_group_path(@group)
    #   expect(page).to have_field("グループ名", with: @group.name)
    #   expect(page).to have_field("キー", with: @group.key)
    # end

    # scenario 'グループ情報を編集できるか' do
    #   @user.user_to_groups.create(group_id: @group.id)
    #   visit edit_group_path(@group)
    #   fill_in "グループ名", with: @group.name
    #   click_on "更新する"
    #   expect(page).to have_content("グループを更新しました")
    # end

    # scenario 'グループを削除できるか' do
    #   @user.user_to_groups.create(group_id: @group.id)
    #   click_on "Groups", match: :first
    #   find(".portfolio-box").click
    #   page.accept_confirm do
    #     click_on "destroy"
    #   end
    #   expect(current_path).to eq root_path
    # end
  end
end
