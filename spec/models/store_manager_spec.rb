require 'rails_helper'

RSpec.describe StoreManager, type: :model do
  before do
    @store_manager = build(:store_manager)
  end

  it "有効なstore_managerを持つこと" do
    expect(@store_manager).to be_valid
  end
  describe 'name' do
    it "名前がなかった場合は無効であること" do
      @store_manager.name = nil
      expect(@store_manager).to be_invalid
    end

    it "名前が1文字以上であること" do
      @store_manager.name = "s"
      expect(@store_manager).to be_valid
    end

    it "名前が30文字以下であれば有効であること" do
      @store_manager.name = SecureRandom.alphanumeric(30)
      expect(@store_manager).to be_valid
    end

    it "名前が31文字以上では無効であること" do
      @store_manager.name = SecureRandom.alphanumeric(31)
      expect(@store_manager).to be_invalid
    end
  end
  describe 'email' do
    it "emailがなかった場合は無効であること" do
      @store_manager.email = nil
      expect(@store_manager).to be_invalid
    end

    it "正規表現外の文字列であった場合は無効であること " do
      @store_manager.email = "sm@com"
      expect(@store_manager).to be_invalid
    end

    it "100文字以上の場合無効である事" do
      @store_manager.email = SecureRandom.alphanumeric(91) + "@email.com"
      expect(@store_manager).to be_invalid
    end

    it "100文字の場合有効である事" do
      @store_manager.email = SecureRandom.alphanumeric(90) + "@email.com"
      expect(@store_manager).to be_valid
    end

    it "同一のメールアドレスの場合は無効であること" do
      create(:store_manager, email: "store_manager@example.com")
      second_store_manager = build(:store_manager, email: "store_manager@example.com")
      expect(second_store_manager).to be_invalid
    end
  end
  describe 'password' do
    it "パスワードがない場合は無効であること" do
      @store_manager.password = nil
      expect(@store_manager).to be_invalid
    end

    it "パスワードは5文字以下は無効であること" do
      @store_manager.password = "passw"
      expect(@store_manager).to be_invalid
    end

    it "パスワードは6文字以上は有効であること" do
      @store_manager.password = "passwo"
      expect(@store_manager).to be_valid
    end
  end
end
