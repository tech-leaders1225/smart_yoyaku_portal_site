class Favorite < ApplicationRecord
  belongs_to :masseur
  belongs_to :user
end
