require 'rails_helper'

RSpec.describe "Users::Registrations", type: :request do
  before do
    @user = create(:user)
  end

  describe "GET new" do
    context "ログインユーザーの場合" do
      # 現在topページにリダイレクトされます。
      it "topページにリダイレクトされること" do
        sign_in @user
        get new_user_registration_path
        expect(response).to redirect_to root_url(@user)
      end
      # it "showページにリダイレクトされること" do
      #   sign_in @user
      #   get new_user_registration_path
      #   expect(response).to redirect_to user_url(@user)
      # end

      it "302httpレスポンスを返すこと" do
        sign_in @user
        get new_user_registration_path
        expect(response.status).to eq 302
      end
    end

    context "ログアウトユーザーの場合" do
      it "newページが表示されること" do
        get new_user_registration_path
        expect(response).to render_template :new
      end

      it "200httpレスポンスを返すこと" do
        get new_user_registration_path
        expect(response.status).to eq 200
      end
    end
  end

  describe "POST create" do
    context "ログアウトユーザーの場合" do
      it "入力内容が正しい場合、新規ユーザーが登録されること" do
        expect do
          post user_registration_path, params: { user: FactoryBot.attributes_for(:user) }
        end.to change(User, :count).by(1)
      end

      it "入力内容が不正な場合、新規ユーザーが登録されないこと" do
        expect do
          post user_registration_path, params: { user: FactoryBot.attributes_for(:user, email: "@email") }
        end.to change(User, :count).by(0)
        expect(response.status).to render_template :new
      end
    end
  end

  describe "GET show" do
    context "ログインユーザーの場合" do
      it "自身のshowページが表示されること" do
        sign_in @user
        get user_path(@user)
        expect(response.status).to render_template :show
      end

      it "他ユーザーのshowページは表示されないこと" do
        other_user = create(:user)
        sign_in @user
        get user_path(other_user)
        expect(response).to redirect_to root_url
      end
    end

    context "ログアウトユーザーの場合" do
      it "ログインページにリダイレクトされること" do
        get user_path(@user)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET edit" do
    context "ログインユーザーの場合" do
      it "自身のeditページが表示されること" do
        sign_in(@user)
        get edit_user_registration_path(@user)
        expect(response.status).to render_template :edit
        expect(response.status).to eq 200
      end
    end

    context "ログアウトユーザーの場合" do
      it "ログインページへリダイレクトされること" do
        get edit_user_registration_path
        expect(response).to redirect_to new_user_session_path
        expect(response.status).to eq 302
      end
    end
  end

  describe "PATCH update" do
    context "ログインユーザーの場合" do
      it "入力内容が正しい場合、自身の情報が更新されること" do
        user_params = FactoryBot.attributes_for(:user, name: "New Name", current_password: "password")
        sign_in @user
        patch user_registration_path, params: { id: @user.id, user: user_params }
        expect(@user.reload.name).to eq "New Name"
        expect(response).to redirect_to user_url(@user)
      end

      it "入力内容が不正な場合、自身の情報が更新されないこと" do
        user_params = FactoryBot.attributes_for(:user, email: "@email", current_password: "password")
        sign_in @user
        patch user_registration_path, params: { id: @user.id, user: user_params }
        expect(@user.reload.email).to_not eq "@email"
        expect(response.status).to render_template :edit 
      end

      it "パスワードを変更しない場合、空欄のままでも更新されること" do
        user_params = FactoryBot.attributes_for(:user,
                                                name: "New Name",
                                                password: "",
                                                password_confirmation: "",
                                                current_password: "password")
        sign_in @user
        patch user_registration_path, params: { id: @user.id, user: user_params }
        expect(@user.reload.name).to eq "New Name"
        expect(response).to redirect_to user_url(@user) 
      end
    end
  end

  describe "DELETE destroy" do
    context "ログインユーザーの場合" do
      it "自身のアカウントを削除できること" do
        sign_in @user
        expect {
        delete user_registration_path, params: { id: @user.id }
        }.to change(User, :count).by(-1)
        expect(response).to redirect_to root_url
      end
    end
  end
end