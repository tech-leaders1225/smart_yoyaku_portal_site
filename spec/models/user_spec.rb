require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  it "全てのカラムに有効な値が入力された場合、有効であること" do
    expect(@user).to be_valid
  end

  describe "name" do
    it "名前が無い場合、無効であること" do
      @user.name = nil
      expect(@user).to be_invalid
    end
  
    it "名前が1文字の場合、有効であること" do
      @user.name = "A"
      expect(@user).to be_valid
    end
  
    it "名前が30文字の場合、有効であること" do
      @user.name = "A" * 30
      expect(@user).to be_valid
    end
  
    it "名前が31文字の場合、無効であること" do
      @user.name = "A" * 31
      expect(@user).to be_invalid
    end
  end

  describe "email" do
    it "メールアドレスが無い場合、無効であること" do
      @user.email = nil
      expect(@user).to be_invalid
    end
  
    it "重複したメールアドレスの場合、無効であること" do
      user = create(:user, email: "email@example.com")
      other_user = build(:user, email: "email@example.com") 
      expect(other_user).to be_invalid
    end
  
    it "不正なフォーマットの場合、無効であること" do
      @user.email = "example.com"
      expect(@user).to be_invalid
    end

    it "メールアドレスが100文字の場合、有効であること" do
      @user.email = "0123456789" * 9 + "@gmail.com"
      expect(@user).to be_valid
    end
  
    it "メールアドレスが101文字の場合、無効であること" do
      @user.email = "0123456789" * 9 + "@ggmail.com"
      expect(@user).to be_invalid
    end
  end

  describe "password" do
    it "パスワードが無い場合、無効であること" do
      @user.password = nil
      expect(@user).to be_invalid
    end
  
    it "パスワードが5文字の場合、無効であること" do
      @user.password = "12345"
      expect(@user).to be_invalid
    end
  
    it "パスワードが6文字の場合、有効であること" do
      @user.password = "123456"
      expect(@user).to be_valid
    end
  end

  describe "nickname" do
    it "ニックネームが無い場合、有効であること" do
      @user.nickname = nil
      expect(@user).to be_valid
    end
    it "ニックネームが1文字の場合、有効であること" do
      @user.nickname = "A"
      expect(@user).to be_valid
    end
  
    it "ニックネームが30文字の場合、有効であること" do
      @user.nickname = "A" * 30
      expect(@user).to be_valid
    end
  
    it "ニックネームが31文字の場合、無効であること" do
      @user.nickname = "A" * 31
      expect(@user).to be_invalid
    end
  end

  describe "address" do
    it "住所が無い場合、無効であること" do
      @user.address = nil
      expect(@user).to be_invalid    
    end
  
    it "住所が4文字の場合、無効であること" do
      @user.address = "A" * 4
      expect(@user).to be_invalid
    end
  
    it "住所が文字の場合、有効であること" do
      @user.address = "A" * 5
      expect(@user).to be_valid
    end

    it "住所が60文字の場合、有効であること" do
      @user.address = "0123456789" * 6
      expect(@user).to be_valid
    end
  
    it "住所が61文字の場合、無効であること" do
      @user.address = "0123456789" * 6 + "A"
      expect(@user).to be_invalid
    end
  end

  describe "gender" do
    it "性別が無い場合、無効であること" do
      @user.gender = nil
      expect(@user).to be_invalid
    end
  
    it "性別がotherの場合、有効であること" do
      @user.gender = "other"
      expect(@user).to be_valid
    end
  end
end
