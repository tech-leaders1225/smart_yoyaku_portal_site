class Storeimage < ApplicationRecord
  belongs_to :store
  mount_uploaders :image, ImageUploader
end
