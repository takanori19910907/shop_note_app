require 'rails_helper'

RSpec.describe "Notes", type: :system do
  let!(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  describe "#create" do

    it "買い物メモを投稿する", js: true do
      visit index_path
      expect {
        fill_in "note_create_form", with: "肉"
        click_button "投稿"
        expect(page).to have_content "肉"
      }.to change(Note, :count).by(1)
    end
  end

  describe "#destroy" do
    context "メモがひとつの時" do
      it "買い物メモを削除する", js: true do
        note = FactoryBot.create(:note, user_id: user.id, content: "果物")
        visit index_path
        expect{
        check "果物"
        click_button "購入しました"
        expect(page).to_not have_content note.content
      }.to change(Note, :count).by(-1)
      end
    end

    context "メモが複数の時" do
      it "指定した複数の買い物メモを削除する",js: true do
        FactoryBot.create(:note, user_id: user.id, content: "買うもの1")
        FactoryBot.create(:note, user_id: user.id, content: "買うもの2")
        FactoryBot.create(:note, user_id: user.id, content: "買うもの3")
        visit index_path
        expect{
        check "買うもの1"
        check "買うもの3"
        click_button "購入しました"
        expect(page).to_not have_content "買うもの1"
        expect(page).to_not have_content "買うもの3"
        expect(page).to have_content "買うもの2"
      }.to change(Note, :count).by(-2)
      end
    end
  end
end
