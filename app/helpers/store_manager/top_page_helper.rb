module StoreManager::TopPageHelper

  # カレンダーの表示／非表示切り替えボタン
  def calendar_btn
    if current_store_manager.order_plan.present?
      link_to "予約カレンダーを#{calendar_btn_message}する", store_manager_update_calendar_status_path, method: :patch,
      data: { confirm: "予約カレンダーを#{calendar_btn_message}します。" } , class: "btn btn-outline-secondary"
    end
  end

  # 切り替えボタンのメッセージ
  def calendar_btn_message
    current_store_manager.store.calendar_status == "released" ? "非公開に" : "公開"
  end
end
