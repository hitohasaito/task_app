require 'rails_helper'

RSpec.feature "ユーザー", type: :feature do
  background do
      @user = FactoryBot.create(:user)
  end

  scenario "ユーザー登録できるとユーザー詳細ページに変移する" do

    visit new_user_path

    fill_in "user[name]", with: "name4"
    fill_in "user[email]", with: "name4@email.com"
    fill_in "user[password]", with: "password4"
    fill_in "user[password_confirmation]", with: "password4"

    click_button "登録する"

    expect(page).to have_content "name4"
    #save_and_open_page
  end

  scenario "メールアドレスとパスワードの組み合わせが合っていればログインできること" do

    visit new_session_path

    fill_in "session[email]", with: "name1@email.com"
    fill_in "session[password]", with: "password1"

    click_button "ログインする"

    visit new_task_path
    #save_and_open_page
  end

  scenario "ログアウトボタンを押すと、ログアウトしてログインページに変移するテスト" do
    visit new_session_path

    fill_in "session[email]", with: "name1@email.com"
    fill_in "session[password]", with: "password1"

    click_button "ログインする"

    visit new_task_path
    #save_and_open_page
    click_link "ログアウト"

    visit new_session_path
    #save_and_open_page
  end

  scenario "ユーザーがログインした状態の時はユーザー登録画面にいけないテスト" do
    visit new_session_path

    fill_in "session[email]", with: "name1@email.com"
    fill_in "session[password]", with: "password1"

    click_button "ログインする"

    visit new_user_path

    expect(page).to have_content("新規登録画面")
  end

  scenario "自分以外のユーザー詳細ページにいけないテスト" do
    visit new_session_path

    fill_in "session[email]", with: "name1@email.com"
    fill_in "session[password]", with: "password1"

    click_button "ログインする"

    visit user_path(@.id)
  end
end
