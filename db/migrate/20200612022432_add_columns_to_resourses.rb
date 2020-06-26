class AddColumnsToResourses < ActiveRecord::Migration[6.0]
  def change
    add_column :store_managers, :smart_token, :string, comment: "予約システム側のUser.token"
    add_column :store_managers, :payment_status, :boolean, default: false, comment: "予約システム側の課金状況"
    add_column :stores, :calendar_id, :string, comment: "予約システム側のCalendar.public_uid"
    add_column :plans, :course_id, :integer, comment: "予約システム側のTaskCourse.id"
    add_column :masseurs, :staff_id, :integer, comment: "予約システム側のStaff.id"
  end
end
