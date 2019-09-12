require 'rails_helper'

RSpec.feature "ユーザー", type: :feature do
  background do
    FactoryBot.build(:user)
    FactoryBot.build(:second_user)
  end

  scenario "ユーザー登録できること" do

    visit new_user_path

    expect {
    fill_in "user[name]", with: "name1"
    fill_in "user[email]", with: "e@email1.com"
    fill_in "user[password]", with: "passwordpassword1"
    fill_in "user[password_confirmation]", with: "passwordpassword1"
    click_button "登録する"
    }.to change(User, :count).to(1)
    #登録したら、ユーザー数が１増えているか確認
  end

  scenario "メールアドレスとパスワードの組み合わせが合っていればログインできること" do

    visit new_session_path
    
    fill_in "session[email]", with: "e@email1.com"
    fill_in "session[password]", with: "passwordpassword1"

    click_button "ログインする"

    visit new_task_path
    #save_and_open_page
  end
end
