module SmartYoyakuApi::Calendar
  include SmartYoyakuApi::User

  private

  # 予約システム側でCalendarの更新を行う    
  def update_calendar(store)
    url = reserve_app_url + "api/v1/calendars"
    `curl -v -X PATCH "#{url}" \
    -d '{"calendar":{"calendar_name":"#{store.store_name}","address":"#{store.adress}","phone":"#{store.store_phonenumber}","public_id":"#{store.calendar_id}"}}' \
    -H 'Accept: application/json' \
    -H 'Content-Type:application/json' \
    -H 'Authorization: Bearer "#{current_store_manager.smart_token}"'`
  end

  # 予約システムのカレンダーの表示／非表示を切り替える
  def update_holiday_flag(store, status)
    url = reserve_app_url + "api/v1/calendars/update_holiday_flag"
    `curl -v -X PATCH "#{url}" \
    -d '{"calendar":{"public_id":"#{store.calendar_id}","status":"#{status}"}}' \
    -H 'Accept: application/json' \
    -H 'Content-Type:application/json' \
    -H 'Authorization: Bearer "#{current_store_manager.smart_token}"'`
  end
end