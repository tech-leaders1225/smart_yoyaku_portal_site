require 'rails_helper'

RSpec.describe "StoreManager::Masseurs", type: :request do

  before do
    @store_manager = create(:store_manager)
  end

  #describe "GET /new" do
  #  context "store_managerがログイン中の場合" do
  #    it "masseurs/newが表示されること" do
  #      sign_in @store_manager
  #      get new_store_manager_masseur_path
  #      expect(response).to have_http_status(:success)
  #      expect(response).to render_template :new
  #      expect(response.status).to eq 200
  #    end
  #  end

  #  context "userがログイン中の場合" do
  #   it "masseurs/newは表示されずstore_managerのログイン画面に遷移すること" do
  #      user = create(:user)
  #      sign_in user
  #      get new_store_manager_masseur_path
  #      expect(response).to redirect_to new_store_manager_session_url
  #      expect(response.status).to eq 302
  #    end
  #  end

  #  context "ログアウト中の場合" do
  #    it "masseurs/newは表示されずstore_managerのログイン画面に遷移すること" do
  #      get new_store_manager_masseur_path
  #      expect(response).to redirect_to new_store_manager_session_url
  #      expect(response.status).to eq 302
  #    end
  #  end
  #end

  #before do
  #  @store = create(:store)
  #end

  #describe "POST /create" do
  #  context "store_managerがログイン中の場合" do
  #    it "入力内容が正しい場合、新規masseurが登録されること" do
  #      sign_in @store.store_manager
  #      expect do
  #        post store_manager_masseurs_path, params: { masseur: FactoryBot.attributes_for(:masseur) }
  #      end.to change(Masseur, :count).by(1)
  #      expect(response).to redirect_to store_manager_masseurs_path        
  #    end

  #    it "入力内容が不正な場合、新規massuerが登録されないこと" do
  #      sign_in @store.store_manager
  #      expect do
  #        post store_manager_masseurs_path, params: { masseur: FactoryBot.attributes_for(:masseur, email: "@email") }
  #      end.to change(Masseur, :count).by(0)
  #      expect(response.status).to render_template :new
  #    end
  #  end
  #end

  before do 
    # 同じstoreに所属する@masseurと@store_managerを作成
    @masseur = create(:masseur)
    @store_manager = @masseur.store.store_manager
  end

  describe "GET /index" do
    context "store_managerがログイン中の場合" do
      it "indexが表示されること" do
        sign_in @store_manager
        get store_manager_masseurs_path(@store_manager)
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

  describe "GET /edit" do
    context "store_managerがログイン中の場合" do
      it "同じstoreを持つmasseurのeditは表示されること" do
        sign_in @store_manager
        get edit_store_manager_masseur_path(@masseur)
        expect(response).to have_http_status(:success)
        expect(response).to render_template :edit
        expect(response.status).to eq 200
      end

      it "別のstoreを持つmasseurのeditは表示されず、管理topへ遷移すること" do
        masseur2 = create(:masseur)
        store_manager2 = masseur2.store.store_manager
        sign_in @store_manager
        get edit_store_manager_masseur_path(masseur2)
        expect(response).to redirect_to store_manager_url(@store_manager)
        expect(response.status).to eq 302
      end
    end

    context "userがログイン中の場合" do
      it "editは表示されずstore_managerのログイン画面に遷移すること" do
        user = create(:user)
        sign_in user
        get edit_store_manager_masseur_path(@masseur)
        expect(response).to redirect_to new_store_manager_session_url
        expect(response.status).to eq 302
      end
    end

    context "ログアウト中の場合" do
      it "masseurs/newは表示されずstore_managerのログイン画面に遷移すること" do
        get edit_store_manager_masseur_path(@masseur)
        expect(response).to redirect_to new_store_manager_session_url
        expect(response.status).to eq 302
      end
    end
  end

  describe "PATCH /update" do
    context "store_managerがログイン中の場合" do
      #it "入力内容が正しい場合、自身の情報が更新されること" do
      #  masseur_params = FactoryBot.attributes_for(:masseur, masseur_name: "New Name")
      #  sign_in @store_manager
      #  patch store_manager_masseur_path(@masseur.id), params: { masseur: masseur_params }
      #  expect(@masseur.reload.masseur_name).to eq "New Name"
      #  expect(response).to redirect_to store_manager_masseurs_path
      #end

      it "入力内容が不正な場合、自身の情報が更新されないこと" do
        masseur_params = FactoryBot.attributes_for(:masseur, email: "@email")
        sign_in @store_manager
        patch store_manager_masseur_path(@masseur.id), params: { masseur: masseur_params }
        expect(@masseur.reload.email).to_not eq "@email"
        expect(response.status).to render_template :edit 
      end

      #it "パスワードを変更しない場合、空欄のままでも更新されること" do  
      #  masseur_params = FactoryBot.attributes_for(:masseur,
      #                                             masseur_name: "New Name",
      #                                             password: "",
      #                                             password_confirmation: "")
      #  sign_in @store_manager
      #  patch store_manager_masseur_path(@masseur.id), params: { masseur: masseur_params }
      #  expect(@masseur.reload.masseur_name).to eq "New Name"
      #  expect(response).to redirect_to redirect_to store_manager_masseurs_path 
      #end
    end
  end

  #describe "DELETE /destroy" do
  #  context "store_managerがログイン中の場合" do
  #    it "同じstoreを持つmassseurを削除できること" do
  #      sign_in @store_manager
  #      expect {
  #      delete store_manager_masseur_path(@masseur.id)
  #      }.to change(Masseur, :count).by(-1)
  #      expect(response).to redirect_to redirect_to store_manager_masseurs_path
  #    end

  #    it "別のstoreを持つmassseurは削除できないこと" do
  #      masseur2 = create(:masseur)
  #      store_manager2 = masseur2.store.store_manager
  #      sign_in @store_manager
  #      expect {
  #      delete store_manager_masseur_path(masseur2.id)
  #      }.to change(Masseur, :count).by(0)
  #      expect(response).to redirect_to redirect_to store_manager_path(@store_manager)
  #    end
  #  end
  #end
end