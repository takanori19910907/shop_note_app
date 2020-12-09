require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:user) { FactoryBot.create(:user) }
  let(:note) { FactoryBot.create(:note) }

  it "content,user_id,note_idがある場合は有効" do
    comment = FactoryBot.build(:comment, user_id: user.id, note_id: note.id)
    expect(comment).to be_valid
  end

  it "contentがない場合は無効" do
    comment = FactoryBot.build(:comment, content: nil, user_id: user.id, note_id: note.id)
    comment.valid?
    expect(comment.errors[:content]).to include("を入力してください")
  end

  it "user_idがない場合は無効" do
    comment = FactoryBot.build(:comment, user_id: nil, note_id: note.id)
    comment.valid?
    expect(comment.errors[:user]).to include("を入力してください")
  end

  it "note_idがない場合は無効" do
    comment = FactoryBot.build(:comment, user_id: user.id, note_id: nil)
    comment.valid?
    expect(comment.errors[:note]).to include("を入力してください")
  end

  it "contentが20文字以下の場合は有効" do
    comment = FactoryBot.build(:comment, content: "c" * 20, user_id: user.id, note_id: note.id)
    expect(comment).to be_valid
  end

  it "contentが21文字以上の場合は無効" do
    comment = FactoryBot.build(:comment, content: "c" * 21, user_id: user.id, note_id: note.id)
    comment.valid?
    expect(comment.errors[:content]).to include("は20文字以内で入力してください")
  end
end
