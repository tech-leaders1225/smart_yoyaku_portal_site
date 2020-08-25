json.array!(@api) do |api|
  json.title api["store_member"]["name"] + "様 :" + api["task_course"]["title"]
  json.start Time.at(api["start_at"]).strftime("%F %T")
  json.end Time.at(api["end_at"]).strftime("%F %T")
  json.name api["store_member"]["name"]
  json.email api["store_member"]["email"]
  json.address api["store_member"]["address"]
  json.phone api["store_member"]["phone"]
  json.course api["task_course"]["title"]
  json.course_time api["task_course"]["course_time"]
  json.charge api["task_course"]["charge"]
  json.request api["request"]
end


