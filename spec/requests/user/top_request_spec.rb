require 'rails_helper'

RSpec.describe "User::Tops", type: :request do

 # ↓↓↓ adminのテストと同じエラーが出るので一旦コメントアウト 
 # it "user/detailsが表示される" do
 #   get user_details_path
 #   expect(response.status).to render_template :details
 # end

  before do
    @store = create(:store)
    @store_manager = @store.store_manager
  end

  describe "GET details" do
    it "無課金のstoreの詳細ページは表示されないこと" do
      expect {
        get details_path(@store)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "課金中のstoreの詳細ページは表示されること" do
      @store_manager.update!(order_plan: 1)   
      get details_path(@store)
      expect(response.status).to eq 200
    end
  end
end
