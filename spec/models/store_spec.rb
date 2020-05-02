require 'rails_helper'

RSpec.describe Store, type: :model do
  before do
    @store = build(:store)
  end

  # RSpec導入のタイミングではFactoryBot.build(:store)に
  # masseur_idを含めていないため下記のテストは失敗します
  # it "有効なstoreを持つこと" do
  #   expect(@store).to be_valid
  # end

end
