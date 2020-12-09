require 'rails_helper'

RSpec.describe Group, type: :model do

  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  it "name、user_idがある場合は有効" do
    group = FactoryBot.build(:group, admin_user_id: user.id)
    expect(group).to be_valid
  end

  it "groupのadmin_user_idが自分のIDになること" do
    group = FactoryBot.build(:group, admin_user_id: user.id)
    expect(group.admin_user_id).to eq user.id
  end

  it "nameがない場合は無効" do
    group = FactoryBot.build(:group, name: nil)
    group.valid?
    expect(group.errors[:name]).to include("を入力してください")
  end

  it "admin_user_idがない場合は無効" do
    group = FactoryBot.build(:group, admin_user_id: nil)
    group.valid?
    expect(group.errors[:admin_user_id]).to include("を入力してください")
  end

  it "admin_user_idが自分のIDでない場合は無効" do
    group = FactoryBot.build(:group, admin_user_id: other_user.id)
    expect(group.admin_user_id).to_not eq user.id
  end

  it "nameが20文字以下の場合は有効" do
    group = FactoryBot.build(:group, name: "n" * 20, admin_user_id: user.id)
    expect(group).to be_valid
  end

  it "nameが21文字以上の場合は無効" do
    group = FactoryBot.build(:group, name: "n" * 21, admin_user_id: user.id)
    group.valid?
    expect(group.errors[:name]).to include "は20文字以内で入力してください"
  end

  it "profileが100文字以下の場合は有効" do
    group = FactoryBot.build(:group, profile: "p" * 100, admin_user_id: user.id)
    expect(group).to be_valid
  end

  it "profileが101文字以上の場合は無効" do
    group = FactoryBot.build(:group, profile: "p" * 101, admin_user_id: user.id)
    group.valid?
    expect(group.errors[:profile]).to include "は100文字以内で入力してください"
  end
end
