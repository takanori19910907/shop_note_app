require 'rails_helper'

RSpec.describe FavoriteItem, type: :model do

  let(:user) { FactoryBot.create(:user) }

  it "name,user_idがある場合は有効" do
    item = FactoryBot.build(:favorite_item, user_id: user.id)
    expect(item).to be_valid
  end

  it "nameがない場合は無効" do
    item = FactoryBot.build(:favorite_item, name: nil, user_id: user.id)
    item.valid?
    expect(item.errors[:name]).to include("を入力してください")
  end

  it "user_idがない場合は無効" do
    item = FactoryBot.build(:favorite_item, user_id: nil)
    item.valid?
    expect(item.errors[:user]).to include("を入力してください")
  end

  it "nameが10文字以下の場合は有効" do
    item = FactoryBot.build(:favorite_item, name: "c" * 10, user_id: user.id)
    expect(item).to be_valid
  end

  it "profileが11文字以上の場合は無効" do
    item = FactoryBot.build(:favorite_item, name: "c" * 11, user_id: user.id)
    item.valid?
    expect(item.errors[:name]).to include "は10文字以内で入力してください"
  end
end
