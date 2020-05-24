class Plan < ApplicationRecord
  belongs_to :store
  has_many :plan_images, dependent: :destroy
  
  validates :plan_name, presence: true, length: { in: 1..35 }
  validates :plan_content, presence: true, length: { in: 1..300 }
  validates :plan_price, presence: true, length: { maximum: 99999 }
  validates :plan_time, presence: true, length: { maximum: 999 }
  
end
