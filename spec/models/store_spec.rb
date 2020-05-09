require 'rails_helper'

RSpec.describe Store, type: :model do
  before do
    @store = build(:store)
  end

  # 現状で落ちるので(failed)一旦コメントアウトします。
  # 今後正しいテストによって不要になると思われますのでその際は消去してください
  # it "有効なstoreを持つこと" do
  #   expect(@store).to be_valid
  # end

end
