require 'rails_helper'

RSpec.describe "Admin::Admins", type: :request do

  before do
    @admin = create(:admin)
  end

  it "ログイン後にadmin専用のdashboardページが表示されること" do
    sign_in(@admin)
    get admin_root_path 
    expect(response).to have_http_status "200"
  end
end
