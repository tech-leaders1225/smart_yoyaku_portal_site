json.array!(@event) do |event|
  json.title event["store_member"]["name"] + "様：" + Time.at(event["start_at"] + 32400).strftime("%F %T") + "〜"
  
  json.task event["store_member"]["name"] + 
  event["store_member"]["email"] + 
  event["store_member"]["phone"] + 
  Time.at(event["start_at"] + 32400).strftime("%T") +
  Time.at(event["end_at"] + 32400).strftime("%T") +
  event["task_course"]["title"] +
  event["request"]
  
  json.start Time.at(event["start_at"] + 32400).strftime("%F %T")
  json.end Time.at(event["end_at"] + 32400).strftime("%F %T")
end