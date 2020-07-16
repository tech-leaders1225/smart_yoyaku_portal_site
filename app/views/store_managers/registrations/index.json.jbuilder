<<<<<<< HEAD
json.array!(@events) do |event|
  json.title event["store_member"]["name"] + "様：" + Time.at(event["start_at"] + 32400).strftime("%F %T") + "〜"
  
  json.name event["store_member"]["name"]
  json.email event["store_member"]["email"]
  json.phone event["store_member"]["phone"]
  json.start Time.at(event["start_at"] + 32400).strftime("%F %T")
  json.start_time Time.at(event["start_at"] + 32400).strftime("%H:%M")
  json.end Time.at(event["end_at"] + 32400).strftime("%F %T")
  json.end_time Time.at(event["end_at"] + 32400).strftime("%H:%M")
  json.task_course event["task_course"]["title"]
  json.course_time event["task_course"]["course_time"]
  json.charge event["task_course"]["charge"]
  json.request event["request"]
end
=======
json.array!(@api) do |api|
  json.title api["store_member"]["name"] + "様 :" + api["task_course"]["title"]
  json.start Time.at(api["start_at"] + 32400).strftime("%F %T")
  json.end Time.at(api["end_at"] + 32400).strftime("%F %T")
  json.name api["store_member"]["name"]
  json.email api["store_member"]["email"]
  json.address api["store_member"]["address"]
  json.phone api["store_member"]["phone"]
  json.course api["task_course"]["title"]
  json.course_time api["task_course"]["course_time"]
  json.charge api["task_course"]["charge"]
  json.request api["request"]
end


>>>>>>> eb31670233fa4ded706f0d019503f73733f6ca69
