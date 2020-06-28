module SmartYoyakuApi::User

  private
 
  # 開発中は各自中身を書き換えて使用してください
  def reserve_app_url
    Rails.env.development? ? "http://localhost:3000/" : "https://smartyoyaku-staging.herokuapp.com/"
  end
  
  # 予約システム側でUserの登録を行う
  def create_user(store_manager, store, plan)
    url = reserve_app_url + "api/v1/users"
    `curl -v POST "#{url}" \
    -d '{"user":{"store_manager_id":"#{store_manager.id}","name":"#{store_manager.name}","email":"#{store_manager.email}","password":"#{store_manager.password}"},\
    "calendar":{"calendar_name":"#{store.store_name}","address":"#{store.adress}","phone":"#{store.store_phonenumber}"},\
    "task_course":{"title":"#{plan.plan_name}","description":"#{plan.plan_content.gsub(/(\r\n|\r|\n)/, "")}","course_time":"#{plan.plan_time}","charge":"#{plan.plan_price}"}}' \
    -H 'Accept: application/json' \
    -H 'Content-Type:application/json'`
  end

  # 予約システム側でUserの更新を行う
  def update_user(reserve_app_url)
    url = reserve_app_url + "api/v1/users/#{current_store_manager.id}"
    `curl -v -X PATCH "#{url}" \
    -d '{"user":{"name":"#{current_store_manager.name}","email":"#{current_store_manager.email}","password":"#{current_store_manager.password}"}}' \
    -H 'Accept: application/json' \
    -H 'Content-Type:application/json' \
    -H 'Authorization: Bearer #{current_store_manager.smart_token}'`
  end
end