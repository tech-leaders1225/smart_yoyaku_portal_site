class Plan < ApplicationRecord
  belongs_to :store
  has_many :plan_images, dependent: :destroy
  accepts_nested_attributes_for :plan_images
  validates :plan_name, presence: true, length: { in: 1..35 }
  validates :plan_content, presence: true, length: { in: 1..300 }
  validates :plan_price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 300000 }
  validates :plan_time, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }
end
