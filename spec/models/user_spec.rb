require 'rails_helper'

RSpec.describe User, type: :model do

  it "バリデーションチェック" do
  user = FactoryBot.build(:user)
  end
end
