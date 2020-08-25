module StoreManager::PlansHelper

  # @plans.firstの削除ボタンのみ非表示
  def delete_plan_btn(plan, plans)
    unless plan == plans.first
      link_to "削除", store_manager_plan_path(plan), method: :delete,
      data: { confirm: "#{plan.plan_name} を削除しますか？" } , class:"btn btn-outline-danger"
    end
  end
end
