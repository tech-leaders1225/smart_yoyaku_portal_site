require 'rails_helper'

RSpec.describe Store, type: :model do
  before do
    @store = build(:store)
  end

  it "有効なstoreを持つこと" do
    expect(@store).to be_valid
  end
end
