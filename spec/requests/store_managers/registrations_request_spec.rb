require 'rails_helper'

RSpec.describe "StoreManagers::Registrations", type: :request do
  before do
    @store_manager = create(:store_manager)
  end

  describe "Get new" do
    context "ログインユーザーの場合" do
      it "topページにリダイレクトされること" do
        sign_in @store_manager
        get new_store_manager_registration_path
        expect(response).to redirect_to root_path(@store_manager)
      end

      it "302httpレスポンスを返すこと" do
        sign_in @store_manager
        get new_store_manager_registration_path
        expect(response.status).to eq 302
      end
    end
    context "ログアウトユーザーの場合" do
      it "newページが表示されること" do
        get new_store_manager_registration_path
        expect(response).to render_template :new
      end

      it "200httpレスポンスを返すこと" do
        get new_store_manager_registration_path
        expect(response.status).to eq 200
      end
    end
  end
  describe "POST create" do
    context "ログアウトユーザーの場合" do
      it "入力内容が正しい場合、新規ユーザーが登録されること" do
        expect do
          post store_manager_registration_path, params: { store_manager: FactoryBot.attributes_for(:store_manager) }
        end.to change(StoreManager, :count).by(1)
      end

      it "入力内容が不正な場合、新規ユーザーが登録されないこと" do
        expect do
          post store_manager_registration_path, params: { store_manager: FactoryBot.attributes_for(:store_manager, email: "@email") }
        end.to change(StoreManager, :count).by(0)
        expect(response.status).to render_template :new
      end
    end
  end
  describe "GET top" do
    context "ログインユーザーの場合" do
      it "自身のtopページが表示されること" do
        sign_in @store_manager
        get store_manager_path(@store_manager)
        expect(response.status).to render_template :top
      end

      it "他ユーザーのtopページは表示されないこと" do
        other_user = create(:store_manager)
        sign_in @store_manager
        get store_manager_path(other_user)
        expect(response).to redirect_to store_manager_path(@store_manager)
      end
    end
    context "ログアウトユーザーの場合" do
      it "ログインページにリダイレクトされること" do
        get store_manager_path(@store_manager)
        expect(response).to redirect_to store_manager_session_path
      end
    end
  end
  describe "GET show" do
    context "ログインユーザーの場合" do
      it "自身のtopページが表示されること" do
        sign_in @store_manager
        get store_managers_show_path(@store_manager)
        expect(response.status).to render_template :show
      end

      it "他ユーザーのtopページは表示されないこと" do
        other_user = create(:store_manager)
        sign_in @store_manager
        get store_managers_show_path(other_user)
        expect(response).to redirect_to store_manager_path(@store_manager)
      end
    end
    context "ログアウトユーザーの場合" do
      it "ログインページにリダイレクトされること" do
        get store_managers_show_path(@store_manager)
        expect(response).to redirect_to store_manager_session_path
      end
    end
  end
  describe "GET edit" do
    context "ログインユーザーの場合" do
      it "自身のeditページが表示されること" do
        sign_in(@store_manager)
        get edit_store_manager_registration_path(@store_manager)
        expect(response.status).to render_template :edit
        expect(response.status).to eq 200
      end
    end

    context "ログアウトユーザーの場合" do
      it "ログインページへリダイレクトされること" do
        get edit_store_manager_registration_path
        expect(response).to redirect_to store_manager_session_path
        expect(response.status).to eq 302
      end
    end
  end
  describe "PATCH update" do
    context "ログインユーザーの場合" do
      it "入力内容が正しい場合、自身の情報が更新されること" do
        store_manager_params = FactoryBot.attributes_for(:store_manager, name: "New Name", current_password: "password")
        sign_in @store_manager
        patch store_manager_registration_path, params: { id: @store_manager.id, store_manager: store_manager_params }
        expect(@store_manager.reload.name).to eq "New Name"
        expect(response).to redirect_to store_manager_url(@store_manager)
      end

      it "入力内容が不正な場合、自身の情報が更新されないこと" do
        store_manager_params = FactoryBot.attributes_for(:store_manager, email: "@email", current_password: "password")
        sign_in @store_manager
        patch store_manager_registration_path, params: { id: @store_manager.id, store_manager: store_manager_params }
        expect(@store_manager.reload.email).to_not eq "@email"
        expect(response.status).to render_template :edit
      end

      it "パスワードを変更しない場合、空欄のままでも更新されること" do
        store_manager_params = FactoryBot.attributes_for(:store_manager,
                                                         name: "New Name",
                                                         password: "",
                                                         password_confirmation: "",
                                                         current_password: "password")
        sign_in @store_manager
        patch store_manager_registration_path, params: { id: @store_manager.id, store_manager: store_manager_params }
        expect(@store_manager.reload.name).to eq "New Name"
        expect(response).to redirect_to store_manager_url(@store_manager) 
      end
    end
  end

  describe "DELETE destroy" do
    context "ログインユーザーの場合" do
      it "自身のアカウントを削除できること" do
        sign_in @store_manager
        expect {
        delete store_manager_registration_path, params: { id: @store_manager.id }
        }.to change(StoreManager, :count).by(-1)
        expect(response).to redirect_to root_url
      end
    end
  end
end