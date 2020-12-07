require 'rails_helper'

RSpec.describe Group, type: :model do
  it "name、user_idがあり、profileが100文字以内であればレコード作成出来ること" do

  end

  it "nameがない場合グループ作成出来ないこと" do

  end

  it "admin_user_idがない場合グループ作成出来ないこと" do

  end

  it "admin_user_idがグループ作成者と同じIDであること" do

  end

  it "profileが101文字以上の場合無効であること" do

  end
end
