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
        expect(page).to have_selector('.alert-success', text: 'グループを作成しました')
        expect(page).to have_content "グループ名:家族グループ"
        expect(page).to have_content "日々買い物するものをここで管理します！"
      }.to change(Group, :count).by(1)
    end
  end

  describe "#destroy" do
    it "グループを削除する", js: true do
      # page.driver.browser.switch_to.alert.accept
      group = FactoryBot.create(:group, admin_user_id: user.id)
      group.group_members.create(group_id: group.id, user_id: user.id)
      visit edit_group_path(user.id)
      # page.accept_confirm do
      #   click_button "削除"
      #   save_and_open_page
      click_button "削除", match: :first
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
end
