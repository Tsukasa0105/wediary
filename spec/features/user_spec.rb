# frozen_string_literal: true

require 'rails_helper'

feature 'User', type: :feature do
  feature 'ユーザー登録前' do
    scenario 'ユーザー登録ができるか' do
      visit root_path # sessionがないのでlogin_pathに移行
      click_on '新規登録はコチラ'
      fill_in 'ユーザ名', with: 'integration_test'
      fill_in 'メールアドレス', with: 'integration_test@gmail.com'
      fill_in 'パスワード', with: 'integration_test'
      fill_in 'パスワード（確認）', with: 'integration_test'
      click_on '登録'
      expect(page).to have_content('ユーザを登録しました。')
    end

    scenario 'ログインできないか' do
      visit root_path # sessionがないのでlogin_pathに移行
      fill_in 'メールアドレス', with: 'integration_test2@gmail.com'
      fill_in 'パスワード', with: 'integration_test2'
      click_on 'ログインする'
      expect(page).to have_content 'ログインに失敗しました。'
    end
  end

  feature 'ユーザー登録後', type: :feature do
    let(:user) { create(:user) }

    background do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_on 'ログインする'
    end

    scenario 'ログインできているか' do
      expect(page).to have_content 'ログインに成功しました。'
    end

    scenario 'ログアウトできるか' do
      click_on 'logout'
      expect(page).to have_content 'ログアウトしました。'
    end

    scenario 'ユーザー情報編集ページに遷移できるか' do
      click_on 'edit_user'
      expect(current_path).to eq edit_user_path(user)
    end

    scenario 'ユーザー情報編集ページのフォームは正しい値か' do
      click_on 'edit_user'
      expect(page).to have_field('ユーザ名', with: user.name)
      expect(page).to have_field('メールアドレス', with: user.email)
    end

    scenario 'ユーザー情報編集ができるか' do
      click_on 'edit_user'
      fill_in 'ユーザ名', with: user.name
      click_on '変更'
      expect(page).to have_content('ユーザー情報を変更しました')
    end

    #     scenario 'ユーザー退会処理ができるか' do
    #       click_on "My page"
    #       click_on "Leave Minimum"
    #       expect(page).to have_content("アカウントを削除しました")
    #     end
  end
end
