require 'rails_helper'

RSpec.feature "ユーザー", type: :feature do
  # background do
  #   FactoryBot.create(:user)
  #   FactoryBot.create(:second_user)
  # end

  scenario "ユーザー登録できるとユーザー詳細ページに変移する" do

    visit new_user_path

    fill_in "user[name]", with: "name1"
    fill_in "user[email]", with: "name1@email.com"
    fill_in "user[password]", with: "password1"
    fill_in "user[password_confirmation]", with: "password1"

    click_button "登録する"

    expect(page).to have_content "name1"
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
end
