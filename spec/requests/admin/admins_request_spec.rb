require 'rails_helper'

RSpec.describe "Admin::Admins", type: :request do

  before do
    @admin = create(:admin)
  end

  it "admin/topが表示される" do
    sign_in(@admin)
    get admin_top_path 
    expect(response.status).to render_template :top
  end
end
