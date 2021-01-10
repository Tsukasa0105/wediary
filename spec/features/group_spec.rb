require 'rails_helper'

feature 'Group', type: :feature do
  feature 'ユーザー登録後', type: :feature do
    
    background do
      @user = FactoryBot.create(:integration_user)
      @group = FactoryBot.create(:group, invited_user_ids: [@user.id])
      visit login_path
      fill_in "メールアドレス", with: @user.email
      fill_in "パスワード", with: @user.password
      click_on "ログインする"
    end
    
    scenario 'グループ登録ができるか' do
      visit new_group_path      
      fill_in "グループ名", with: "integration_test"
      fill_in "キー", with: "integration_test"
      check(@user.name)
      click_on "登録する"
      expect(page).to have_content("グループを作成しました")
    end

    # binding.pry
    
    scenario 'groups/indexに遷移できるか' do
      click_on "Groups", match: :first
      expect(current_path).to eq root_path
    end
    
    scenario 'inviting_groups_user_pathに遷移できるか' do
      click_on "Groups", match: :first
      click_on "招待中"
      expect(current_path).to eq inviting_groups_user_path(@user)
    end
    
    scenario 'group_to_userとuser_to_groupが機能していない場合、inviting_groups_user_pathからgroups/showに遷移できるか' do
      click_on "Groups", match: :first
      click_on "招待中"
      find(".portfolio-box").click
      expect(current_path).to eq group_path(@group)
      expect(page).to have_content("このグループのメンバーではありません")
    end
    
    scenario '招待中のグループのメンバーになる' do
      click_on "Groups", match: :first
      click_on "招待中"
      click_on "メンバーになる", match: :first
      expect(current_path).to eq search_groups_path
    end
    
    scenario 'group_to_userとuser_to_groupが機能している場合、group_pathからgroups/showに遷移できるか' do
      @user.user_to_groups.create(group_id: @group.id)
      click_on "Groups", match: :first
      find(".portfolio-box").click
      expect(current_path).to eq group_path(@group)
      expect(page).to have_content(@group.name)
    end
    
    scenario 'groups/editに遷移できるか' do
      @user.user_to_groups.create(group_id: @group.id)
      click_on "Groups", match: :first
      find(".portfolio-box").click
      click_on "edit_group"
      expect(current_path).to eq edit_group_path(@group)
    end
    
    scenario 'groups/editのフォームは正しい値か' do
      @user.user_to_groups.create(group_id: @group.id)
      visit edit_group_path(@group)
      expect(page).to have_field("グループ名", with: @group.name)
      expect(page).to have_field("キー", with: @group.key)
    end
    
    scenario 'グループ情報を編集できるか' do
      @user.user_to_groups.create(group_id: @group.id)
      visit edit_group_path(@group)
      fill_in "グループ名", with: @group.name
      click_on "更新する"
      expect(page).to have_content("グループを更新しました")
    end
    
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