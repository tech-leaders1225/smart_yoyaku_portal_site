module SmartYoyakuApi::TaskCourse
  include SmartYoyakuApi::User

  private

  def task_course_create(plan)
    url = reserve_app_url + "api/v1/task_courses"
    `curl -v POST "#{url}" \
    -d '{"task_course":{"title":"#{plan.plan_name}","description":"#{plan.plan_content.gsub(/(\r\n|\r|\n)/, "")}","course_time":"#{plan.plan_time}","charge":"#{plan.plan_price}","calendar_id":"#{plan.store.calendar_secret_id}"}}' \
    -H 'Accept: application/json' \
    -H 'Content-Type:application/json' \
    -H 'Authorization: Bearer "#{current_store_manager.smart_token}"'`
  end

  def task_course_update(plan)
    url = reserve_app_url + "api/v1/task_courses/#{plan.course_id}"
    `curl -v -X PATCH "#{url}" \
    -d '{"task_course":{"title":"#{plan.plan_name}","description":"#{plan.plan_content.gsub(/(\r\n|\r|\n)/, "")}","course_time":"#{plan.plan_time}","charge":"#{plan.plan_price}","calendar_id":"#{plan.store.calendar_secret_id}"}}' \
    -H 'Accept: application/json' \
    -H 'Content-Type:application/json' \
    -H 'Authorization: Bearer "#{current_store_manager.smart_token}"'`
  end

  def task_course_delete(plan)
    url = reserve_app_url + "api/v1/task_courses/#{plan.course_id}"
    `curl -v -X DELETE "#{url}" \
    -H 'Authorization: Bearer "#{current_store_manager.smart_token}"'`
  end
end