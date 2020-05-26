require 'rails_helper'

RSpec.describe "StoreManager::Plans", type: :request do
  before do 
    # 同じstoreに所属する@masseurと@store_managerを作成
    @plan = create(:plan)
    @store_manager = @plan.store.store_manager
  end
  
  describe "GET /index" do
    context "store_managerがログイン中の場合" do
      it "同じstoreを持つplanのindexが表示されること" do
        sign_in @store_manager
        get store_manager_plans_path(@store_manager)
        expect(response).to have_http_status(:success)
        expect(response).to render_template :index
        expect(response.status).to eq 200
      end
    end
    context "userがログイン中の場合" do
      it "indexは表示されずstore_managerのログイン画面に遷移すること" do
          user = create(:user)
          sign_in user
          get store_manager_masseurs_path
          expect(response).to redirect_to new_store_manager_session_url
          expect(response.status).to eq 302
      end
    end
    
    context "ログアウト中の場合" do
      it "indexは表示されずstore_managerのログイン画面に遷移すること" do
        get store_manager_masseurs_path
        expect(response).to redirect_to new_store_manager_session_url
        expect(response.status).to eq 302
      end
    end
  end
  
  describe "GET /new" do
    context "store_managerがログイン中の場合" do
      it "同じstoreを持つplanのnewが表示されること" do
        sign_in @store_manager
        get new_store_manager_plan_path(@store_manager)
        expect(response).to have_http_status(:success)
        expect(response).to render_template :new
        expect(response.status).to eq 200
      end
      
      it "別のstoreを持つのplanのnewは表示されず管理topへ遷移すること" do
        plan = create(:plan)
        plan = plan.store.store_manager
        sign_in @store_manager
        get new_store_manager_plan_path(plan)
        expect(response).to redirect_to store_manager_url(@store_manager)
        expect(response.status).to eq 302
      end
    end
    
    
  end
  
  describe "GET /show" do
    context "store_managerがログイン中の場合" do
      it "同じstoreを持つplanのshowが表示されること" do
        sign_in @store_manager
        get store_manager_plan_path(@store_manager)
        expect(response).to have_http_status(:success)
        expect(response).to render_template :show
        expect(response.status).to eq 200
      end
    end
  end
  
  describe "GET /edit" do
    context "store_managerがログイン中の場合" do
      it "同じstoreを持つplanのeditが表示されること" do
        sign_in @store_manager
        get edit_store_manager_plan_path(@store_manager)
        expect(response).to have_http_status(:success)
        expect(response).to render_template :edit
        expect(response.status).to eq 200
      end
    end
  end
  
end