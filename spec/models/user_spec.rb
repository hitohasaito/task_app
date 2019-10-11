require 'rails_helper'

RSpec.describe User, type: :model do

  it "name,email,passwordが空ならバリデーションが通らない" do
    user = User.new(name: '', email: '', password: '')
    expect(user).not_to be_valid
  end
end
