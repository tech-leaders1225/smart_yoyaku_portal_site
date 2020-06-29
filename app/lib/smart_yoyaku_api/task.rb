module SmartYoyakuApi::Task

  def task_create(plan)
    #アクセスするURLの指定 localなので現在であるとhttp本番ではhttpsになる
    url = URI(reserve_app_url + "api/v1/task_courses")
    #httpリクエストの開始
    http = Net::HTTP.new(url.host, url.port);
    request = Net::HTTP::Post.new(url)
    request["Authorization"] = "Bearer #{plan.store.store_manager.smart_token}"
    request["Content-Type"] = "application/json"
    #リクエストを送る内容 plan.storeでストアの情報は取得可能
    request.body = "{\n\t\"title\": \"#{plan.plan_name}\",\n\t\"description\":\"#{plan.plan_content}\",\n\t\"course_time\": #{plan.plan_time} ,\n\t\"calendar_id\": #{plan.store.calendar_secret_id},\n\t\"charge\": #{plan.plan_price}\n}"
    #requestデータの送信
    response = http.request(request)
    JSON.parse(response.body)
  end

  def task_update(plan)
    if Rails.env.development?
      url = URI(reserve_app_url + "api/v1/task_courses/#{plan.course_id}")
    end
    http = Net::HTTP.new(url.host, url.port);
    request = Net::HTTP::Patch.new(url)
    request["Authorization"] = "Bearer #{plan.store.store_manager.smart_token}"
    request["Content-Type"] = "application/json"
    request.body = "{\n\t\"title\": \"#{plan.plan_name}\",\n\t\"description\":\"#{plan.plan_content}\",\n\t\"course_time\": #{plan.plan_time} ,\n\t\"calendar_id\": #{plan.store.calendar_secret_id},\n\t\"charge\": #{plan.plan_price}\n}"
    response = http.request(request)
    JSON.parse(response.body)
  end

  def task_delete(plan)
    url = URI(reserve_app_url + "api/v1/task_courses/#{plan.course_id}")
    http = Net::HTTP.new(url.host, url.port);
    request = Net::HTTP::Delete.new(url)
    request["Authorization"] = "Bearer #{plan.store.store_manager.smart_token}"
    response = http.request(request)
    JSON.parse(response.body)
  end

  def reserve_app_url
    Rails.env.development? ? "http://localhost:3000/" : "https://smartyoyaku-staging.herokuapp.com/"
  end

  module_function :task_create, :task_update, :task_delete, :reserve_app_url
end