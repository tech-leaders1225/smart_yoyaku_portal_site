module TopHelper

  def category
    @category.present? ? "【#{@category.category_name}】" : "全てのマッサージ店"
  end
end
