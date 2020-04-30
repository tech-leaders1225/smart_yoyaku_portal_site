require 'rails_helper'

RSpec.describe StoreManager, type: :model do
  before do
    @store_manager = build(:store_manager)
  end

  it "有効なstore_managerを持つこと" do
    expect(@store_manager).to be_valid
  end
end
