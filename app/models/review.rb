class Review < ApplicationRecord
  belongs_to :masseur
  belongs_to :user
end
