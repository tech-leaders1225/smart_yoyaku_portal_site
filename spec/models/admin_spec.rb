require 'rails_helper'

RSpec.describe Admin, type: :model do
  before do
    @admin = build(:admin)
  end

  it "有効なadminを持つこと" do
    expect(@admin).to be_valid
  end

  it "emailが無ければ無効な状態であること" do
    @admin.email = ''
    @admin.valid?
    expect(@admin.errors[:email]).to include("can't be blank")
  end

end
