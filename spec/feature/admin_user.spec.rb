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

  scenario "ユーザーを編集" do
    visit edit_admin_user_path(@admin_user.id)

    fill_in "user[name]", with: "name1_edit"
    fill_in "user[email]", with: "name1@email.com"
    fill_in "user[password]", with: "password1"
    fill_in "user[password_confirmation]", with: "password1"

    click_button "更新する"

    expect(page).to have_content "name1_edit"
    #save_and_open_page
  end

  scenario "ユーザー詳細を表示" do
    visit admin_user_path(@admin_user.id)

    expect(page).to have_content "name1"
  end

  scenario "ユーザーを削除すると紐づいているタスクも削除される" do
    @user.tasks.create(task_name: "テスト", task_body: "テストです")
    #byebug
    expect{ @user.destroy }.to change{ Task.count }.by(-1)
    #byebug
  end

  scenario "管理者以外が管理者ページにアクセスしようとすると、ログインページに飛ぶ" do
    click_link "ログアウト"

    visit new_session_path
    #second_userでログイン
    fill_in "session[email]", with: "name2@email.com"
    fill_in "session[password]", with: "password2"

    click_button "ログインする"

    visit new_admin_user_path

    visit new_session_path
  end
end
