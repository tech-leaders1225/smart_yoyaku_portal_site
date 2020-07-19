module StoreManager::BusinessTripRangesHelper
  require 'net/http'
  require 'uri'
  require 'json'
  
  # 都道府県のAPIを叩き、データを出力
  def prefectures_api(url)
    uri = URI.parse(URI.escape(url))

    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    param = {}
    param['X-API-KEY'] = '7FrTYfKCKrCfbWmBFw8OHhXBZzwpl6LURz8R3ZKp' # 自分が取得したAPI-KEY

    req = Net::HTTP::Get.new(uri.request_uri, param)
    res = https.request(req)

    json = res.body
    result = JSON.parse(json)
  end
  
  def set_prefectures
    # 現在のマッサージ師に紐づく出張範囲が登録されていなかった場合、都道府県のデータを作成
    if @current_masseur.business_trip_ranges.blank?
      ActiveRecord::Base.transaction do
        # Prefecture.all.each { |prefecture| @current_masseur.business_trip_ranges.create!(prefecture_id: prefecture.id, prefecture_name: prefecture.name) }
        # 東京に紐づげられた市/区のデータを作成
        City.all.each { |city| @current_masseur.business_trip_ranges.create!(city_name: city.name, city_id: city.id) }
      end
    end

  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "ページ情報の取得に失敗しました、再アクセスしてください。"
    redirect_to new_store_manager_masseur_business_trip_range_url
  end
  
end