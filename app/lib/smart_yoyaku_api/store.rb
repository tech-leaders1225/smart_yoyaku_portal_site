module SmartYoyakuApi::Store
  include SmartYoyakuApi::User

  # 予約システム側でCalendarの更新を行う    
  def update_calendar(store)
    url = reserve_app_url + "api/v1/calendars"
    `curl -v -X PATCH "#{url}" \
    -d '{"calendar":{"calendar_name":"#{store.store_name}","address":"#{store.adress}","phone":"#{store.store_phonenumber}","public_id":"#{store.calendar_id}"}}' \
    -H 'Accept: application/json' \
    -H 'Content-Type:application/json' \
    -H 'Authorization: Bearer "#{current_store_manager.smart_token}"'`
  end
end