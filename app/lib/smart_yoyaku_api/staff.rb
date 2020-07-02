module SmartYoyakuApi::Staff
  include SmartYoyakuApi::User

  private

  # 予約システム側のStaff情報を更新    
  def update_staff(masseur)
    url = reserve_app_url + "api/v1/staffs/#{masseur.staff_id}"
    `curl -v -X PATCH "#{url}" \
    -d '{"staff":{"name":"#{masseur.masseur_name}","email":"#{masseur.email}","password":"#{params[:masseur][:password]}","password_confirmation":"#{params[:masseur][:password_confirmation]}"}}' \
    -H 'Accept: application/json' \
    -H 'Content-Type:application/json' \
    -H 'Authorization: Bearer "#{current_store_manager.smart_token}"'`
  end
end