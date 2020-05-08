require 'rails_helper'

RSpec.describe Masseur, type: :model do
  before do
    @masseur = build(:masseur)
  end

  it "有効なmasseurを持つこと" do
    expect(@masseur).to be_valid
  end
  it "store_idがなければ無効であること" do
    @masseur.store_id = nil
    expect(@masseur).to be_invalid
  end

  describe 'masseur_name' do
    it "名前がない場合は無効であること" do
      @masseur.masseur_name = nil
      expect(@masseur).to be_invalid
    end

    it "名前は30文字まで有効であること" do
      @masseur.masseur_name = SecureRandom.alphanumeric(30)
      expect(@masseur).to be_valid
    end

    it "名前が31文字以上は無効であること" do
     @masseur.masseur_name = SecureRandom.alphanumeric(31)
     expect(@masseur).to be_invalid
    end
  end
  describe 'email' do
    it "メールアドレスがない場合は無効であること" do
      @masseur.email = nil
      expect(@masseur).to be_invalid
    end

    it "正規表現外の文字列であった場合は無効であること" do
      @masseur.email = "sm@com"
      expect(@masseur).to be_invalid
    end

    it "メールアドレスが101文字以上の場合は無効であること" do
      @masseur.email = SecureRandom.alphanumeric(91) + "@email.com"
      expect(@masseur).to be_invalid
    end

    it "メールアドレスが100文字以下の場合は有効であること" do
      @masseur.email = SecureRandom.alphanumeric(90) + "@email.com"
      expect(@masseur).to be_valid
    end

    it "同一のメールアドレスの場合は無効であること" do
      create(:masseur, email: "masseur@example.com")
      second_masseur = build(:masseur, email: "masseur@example.com")
      expect(second_masseur).to be_invalid
    end
  end
  describe 'password' do
    it "パスワードがない場合は無効であること" do
      @masseur.password = nil
      expect(@masseur).to be_invalid
    end

    it "パスワードが5文字以下の場合は無効であること" do
      @masseur.password = "passw"
      expect(@masseur).to be_invalid
    end

    it "パスワードが6文字以上の場合は有効であること" do
      @masseur.password = "passwor"
      expect(@masseur).to be_valid
    end
  end
  describe 'adress' do
    it "住所が入力されていない場合有効であること" do
      @masseur.adress = nil
      expect(@masseur).to be_valid
    end

    it "住所が入力されている際に4文字以下は無効であること" do
      @masseur.adress = "adre"
      expect(@masseur).to be_invalid
    end

    it "住所が入力されている際に5文字以上60文字以下は有効であること" do
      @masseur.adress = "adree"
      expect(@masseur).to be_valid
    end

    it "住所が入力されている際に60文字以下5文字以上は有効であること" do
      @masseur.adress = SecureRandom.alphanumeric(60)
      expect(@masseur).to be_valid
    end

    it "住所が入力されている際に61文字以上は無効であること" do
      @masseur.adress = SecureRandom.alphanumeric(61)
      expect(@masseur).to be_invalid
    end
  end
  describe 'phone_number' do
    it "電話番号がない場合有効であること" do
      @masseur.phone_number = nil
      expect(@masseur).to be_valid
    end

    it "電話番号が9文字以下の場合は無効であること" do
      @masseur.phone_number = "012345678"
      expect(@masseur).to be_invalid
    end

    it "電話番号が10文字以上であれば有効であること" do
      @masseur.phone_number = SecureRandom.alphanumeric(10)
      expect(@masseur).to be_valid
    end
  end
end
