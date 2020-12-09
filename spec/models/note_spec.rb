require 'rails_helper'

RSpec.describe Note, type: :model do

  let(:user) { FactoryBot.create(:user) }

  it "content,user_idがある場合は有効" do
    note = FactoryBot.build(:note, user_id: user.id)
    expect(note).to be_valid
  end

  it "contentがない場合は無効" do
    note = FactoryBot.build(:note, content: nil)
    note.valid?
    expect(note.errors[:content]).to include("を入力してください")
  end

  it "user_idがない場合は無効" do
    note = FactoryBot.build(:note, user_id: nil)
    note.valid?
    expect(note.errors[:user_id]).to include("を入力してください")
  end

  it "contentの文字数が31文字以下の場合は有効" do
    note = FactoryBot.build(:note, user_id: user.id,content: "c" * 30)
    expect(note).to be_valid
  end

  it "contentの文字数が31文字以上の場合は無効" do
    note = FactoryBot.build(:note, user_id: user.id, content: "c" * 31)
    note.valid?
    expect(note.errors[:content]).to include("は30文字以内で入力してください")
  end
end
