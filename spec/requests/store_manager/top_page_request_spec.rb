require 'rails_helper'

RSpec.describe "StoreManager::TopPages", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/store_manager/top_page/new"
      expect(response).to have_http_status(:success)
    end
  end

end
