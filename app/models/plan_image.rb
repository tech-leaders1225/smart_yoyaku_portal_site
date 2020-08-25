class PlanImage < ApplicationRecord
  belongs_to :plan
  mount_uploaders :plan_image, PlanImageUploader
end
