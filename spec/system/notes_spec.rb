require 'rails_helper'

RSpec.describe "Notes", type: :system do
  let!(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
    visit root_path
  end

  describe "#create" do
    
    it "買い物メモを投稿する", js: true do
      expect {
        fill_in "note_create_form", with: "肉"
        click_button "投稿"
        expect(page).to have_content "肉"
      }.to change(Note, :count).by(1)
    end

    it "画像付きの買い物メモを投稿する" do

    end

    it "画像のみの買い物メモを投稿する" do

    end
  end

  describe "#destroy" do
    context "メモがひとつの時" do
      it "買い物メモを削除する", js: true do
        note = FactoryBot.create(:note, user_id: user.id, content: "果物")
        visit root_path
        expect{
        check "果物"
        click_button "購入しました"
        expect(page).to_not have_content note.content
      }.to change(Note, :count).by(-1)
      end
    end

    context "メモが複数の時" do
      it "指定した複数の買い物メモを削除する",js: true do
        notes = FactoryBot.create_list(:note, 5 ,user_id: user.id)
        visit root_path
        expect{
        check "買うもの2"
        check "買うもの5"
        click_button "購入しました"
        expect(page).to_not have_content "買うもの2"
        expect(page).to_not have_content "買うもの5"
      }.to change(Note, :count).by(-2)
      end
    end
  end

  describe "#count" do
    it "投稿済みの買い物メモに対して購入数を指定する", js:true do
      # note = FactoryBot.create(:note, user_id: user.id)
      # visit root_path
      # expect(page).to have_selector('.modal', visible: false)
      # page.evaluate_script('$(".fade").removeClass("fade")')
      # within '買うもの1' do
      #   find_button('カード情報を編集する').click
      # end
      # save_screenshot
      # click_button "#count_Modal"
      # select 2 ,from: "数量入力欄"
      # click_button "投稿する"
      # page.should have_content('a_modal_content_here')
    end
  end
end
