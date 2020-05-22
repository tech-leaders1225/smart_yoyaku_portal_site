class PlanImage < ApplicationRecord
  belongs_to :plan, dependent: :destroy
end
