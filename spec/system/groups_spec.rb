require 'rails_helper'

RSpec.describe "Groups", type: :system do

  let!(:user) { FactoryBot.create(:user) }

  before do
    driven_by(:rack_test)
    sign_in user
  end

  describe "#create" do
    it "クループを作成する" do
      visit new_group_path
      expect {
        fill_in "group[name]", with: "家族グループ"
        fill_in "group[profile]", with: "日々買い物するものをここで管理します！"
        click_button "グループ登録完了"
        expect(page).to have_selector(".alert-success", text: "グループを作成しました")
        expect(page).to have_content "グループ名:家族グループ"
        expect(page).to have_content "日々買い物するものをここで管理します！"
      }.to change(Group, :count).by(1)
    end
  end

  describe "#update" do

  let!(:group) {FactoryBot.create(:group, admin_user_id: user.id)}

    it "グループ情報を変更する" do
      group.group_members.create(group_id: group.id, user_id: user.id)

      visit edit_group_path(group)
      fill_in "group[name]", with: "有吉家の買い物メモ"
      fill_in "group[profile]", with: "結婚に伴い改名します！"
      click_button "グループ情報変更"
      expect(page).to have_selector(".alert-success", text: "グループ情報を変更しました")
      expect(page).to have_content "グループ名:有吉家の買い物メモ"
      expect(page).to have_content "結婚に伴い改名します！"

    end
  end

  describe "#destroy" do
    it "グループを削除する", js: true do
      group = FactoryBot.create(:group, admin_user_id: user.id)
      group.group_members.create(group_id: group.id, user_id: user.id)
      visit edit_group_path(user.id)

    # expect {
      # page.accept_confirm "本当に削除しますか?"
      # expect(page).to have_content "Task was successfully destroyed."
    # }.to change(Group, :count).by(-1)
      # expect{
      #   expect(page.accept_confirm).to eq "本当に削除しますか？"
      #   expect(page).to have_content "グループを削除しました"
      #   }. to change(user.groups, :count).by(-1)
    end
  end

  describe "#group_request" do
    let!(:group) { FactoryBot.create(:group, admin_user_id: user.id, name: "家族グループ") }
    let!(:other_user) { FactoryBot.create(:user, name: "嫁" ) }

    context "グループ詳細画面から移動し招待する場合" do
      it "other_userをgroupに招待する" do
        visit group_path(group)
        fill_in "search_form", with: "嫁"
        click_button "検索"
        expect {
        click_button "グループ招待する"
      }.to change(group.group_members, :count).by(1)
        expect(page).to have_selector(".alert-success", text: "#{other_user.name}さんを招待しました")
        expect(page).to have_button "リクエストを解除"
      end

      context "other_userを招待中の場合" do
        let!(:member) { FactoryBot.create(:group_member,
                                          group_id: group.id,
                                          user_id: other_user.id,
                                          activated: false) }

        it "other_userへのグループ招待を取り消す" do
          visit group_path(group)
          fill_in "search_form", with: "嫁"
          click_button "検索"
          expect {
          click_button "リクエストを解除"
          expect(page).to have_button "グループ招待する"
        }.to change(other_user.group_members, :count).by(-1)
        end
      end
    end

    context "ユーザー検索画面から移動し招待する場合" do
      it "other_userをgroupに招待する" do
        # visit root_path
        # click_link "ユーザー検索"
        # fill_in "search_form", with: "嫁"
        # click_button "検索"
        # select "家族グループ", from: "group_id"
      end
    end
  end

  describe "#join" do
    let!(:group) { FactoryBot.create(:group, admin_user_id: user.id, name: "音楽サークルの買い出し部屋") }
    let!(:member) { FactoryBot.create(:group_member,
                                      group_id: group.id,
                                      user_id: user.id,
                                      activated: false) }

    it "招待されているグループに参加する" do
      visit root_path
      expect(page).to have_content "グループリクエスト一覧 1件"
      click_link "グループリクエスト一覧"
      click_button "グループに入る"
      expect(page).to have_selector(".alert-success", text: "グループに参加しました")
      expect(page).to have_content "ルーム名：音楽サークルの買い出し部屋"
    end

    it "グループからの招待を断る" do
      visit root_path
      click_link "グループリクエスト一覧"
      click_button "キャンセル"
      expect(page).to have_selector(".alert-success", text: "リクエストをキャンセルしました")
      expect(page).to have_content "現在グループリクエストはありません"
    end
  end

  describe "#chatroom" do
    let!(:other_user) { FactoryBot.create(:user, name: "嫁" ) }
    let!(:group) { FactoryBot.create(:group, admin_user_id: user.id, name: "家族グループ") }
    let!(:member1) { FactoryBot.create(:group_member,
                                      group_id: group.id,
                                      user_id: user.id,
                                      activated: true) }
    let!(:member2) { FactoryBot.create(:group_member,
                                      group_id: group.id,
                                      user_id: other_user.id,
                                      activated: true) }

    describe "#create note" do
      it "買い物メモを投稿する" do
        visit chatroom_group_path(group)
        expect {
          fill_in "note_create_form", with: "野菜"
          click_button "投稿"
          expect(page).to have_content "野菜"
        }.to change(Note, :count).by(1)
        expect(page).to have_content "野菜"
      end
    end

    describe "#destroy" do
      context "メモがひとつの時" do
        it "買い物メモを削除する", js: true do
          group_note = FactoryBot.create(:note, user_id: user.id, content: "果物")
          visit root_path
          expect{
          check "果物"
          click_button "購入しました"
          expect(page).to_not have_content group_note.content
        }.to change(Note, :count).by(-1)
        end
      end

      context "メモが複数の時" do
        it "指定した複数の買い物メモを削除する",js: true do
          FactoryBot.create(:note, user_id: user.id, content: "買うもの1")
          FactoryBot.create(:note, user_id: user.id, content: "買うもの2")
          FactoryBot.create(:note, user_id: user.id, content: "買うもの3")
          visit root_path
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
end
