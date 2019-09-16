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
    save_and_open_page
  end
end
