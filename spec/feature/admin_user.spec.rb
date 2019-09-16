require 'rails_helper'

RSpec.feature "ユーザー管理機能", type: :feature do
  background do
    @admin_user = FactoryBot.create(:user, admin: "true")
    @user = FactoryBot.create(:second_user)

    #管理者userでログイン
    visit new_session_path

    fill_in "session[email]", with: "name1@email.com"
    fill_in "session[password]", with: "password1"

    click_button "ログインする"

  end

  scenario "ユーザー一覧画面を表示" do
    visit admin_users_path

    expect(page).to have_content "name1"
    expect(page).to have_content "name2"
    #ave_and_open_page
  end

  scenario "管理者ユーザー作成" do
    visit new_admin_user_path

    fill_in "user[name]", with: "name3"
    fill_in "user[email]", with: "name3@email.com"
    fill_in "user[password]", with: "password3"
    fill_in "user[password_confirmation]", with: "password3"
    check '管理者権限'

    click_button "登録する"

    expect(page).to have_content "name3"
    #save_and_open_page
  end
end
