class PlanImage < ApplicationRecord
  belongs_to :plan, dependent: :delete_all
end
