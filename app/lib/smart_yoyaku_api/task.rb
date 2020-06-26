module SmartYoyakuApi::Task

  def task_create(plan)
    if Rails.env.development?
      #アクセスするURLの指定 localなので現在であるとhttp本番ではhttpsになる
      url = URI("http://localhost:3000/api/v1/task_courses")
    end
    #httpリクエストの開始
    http = Net::HTTP.new(url.host, url.port);
    request = Net::HTTP::Post.new(url)
    # request["Authorization"] = "Bearer #{plan.store.store_manager.smart_token}"
    request["Authorization"] = "Bearer 2uhazKArWRqF3Xt6GaLm8gDH"
    request["Content-Type"] = "application/json"
    #リクエストを送る内容 plan.storeでストアの情報は取得可能
    request.body = "{\n\t\"title\": \"#{plan.plan_name}\",\n\t\"description\":\"#{plan.plan_content}\",\n\t\"course_time\": #{plan.plan_time} ,\n\t\"calendar_id\": 1,\n\t\"charge\": #{plan.plan_price}\n}"
    #requestデータの送信
    response = http.request(request)
    JSON.parse(response.body)
  end

  def task_update(plan)
    if Rails.env.development?
      url = URI("http://localhost:3000/api/v1/task_courses/#{plan.course_id}")
    end
    http = Net::HTTP.new(url.host, url.port);
    request = Net::HTTP::Patch.new(url)
    # request["Authorization"] = "Bearer #{plan.store.store_manager.smart_token}"
    request["Authorization"] = "Bearer 2uhazKArWRqF3Xt6GaLm8gDH"
    request["Content-Type"] = "application/json"
    # request.body = "{\n\t\"title\": \"#{plan.plan_name}\",\n\t\"description\":\"#{plan.plan_content}\",\n\t\"course_time\": #{plan.plan_time} ,\n\t\"calendar_id\": #{plan.store.calendar_id},\n\t\"charge\": #{plan.plan_price}\n}"
    request.body = "{\n\t\"title\": \"#{plan.plan_name}\",\n\t\"description\":\"#{plan.plan_content}\",\n\t\"course_time\": #{plan.plan_time} ,\n\t\"calendar_id\": 1,\n\t\"charge\": #{plan.plan_price}\n}"
    response = http.request(request)
    # JSON.parse(response.body)
  end

  def task_delete(plan)
    if Rails.env.development?
      url = URI("http://localhost:3000/api/v1/task_courses/#{plan.course_id}")
    end
    http = Net::HTTP.new(url.host, url.port);
    request = Net::HTTP::Delete.new(url)
    # request["Authorization"] = "Bearer #{plan.store.store_manager.smart_token}"
    request["Authorization"] = "Bearer Qu3XffqXYMviZSv2cKGnNT2Q"
    response = http.request(request)
    # JSON.parse(response.body)
  end
  module_function :task_create, :task_update, :task_delete
end