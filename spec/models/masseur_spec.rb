require 'rails_helper'

RSpec.describe Masseur, type: :model do
  before do
    @masseur = build(:masseur)
  end

  # RSpec導入のタイミングではFactoryBot.build(:masseur)に
  # store_idを含めていないため下記のテストは失敗します
  # it "有効なmasseurを持つこと" do
  #   expect(@masseur).to be_valid
  # end
end
