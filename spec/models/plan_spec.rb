require 'rails_helper'

RSpec.describe Plan, type: :model do
  before do
    @plan = build(:plan)
  end
  
  it "store_idがなければ無効であること" do
    @plan.store_id = nil
    expect(@plan).to be_invalid
  end
  
  describe 'masseur_name' do
    it "プラン名が無い場合、無効であること" do
      @plan.name = nil
      expect(@plan).to be_invalid
    end
    it "プラン内容が無い場合、無効であること" do
      @plan.plan_content = nil
      expect(@plan).to be_invalid
    end
    it "プラン時間が無い場合、無効であること" do
      @plan.plan_time = nil
      expect(@plan).to be_invalid
    end
    it "プラン料金が無い場合、無効であること" do
      @plan.plan_price = nil
      expect(@plan).to be_invalid
    end
  end
end
