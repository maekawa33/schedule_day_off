class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :schedule
  counter_culture :schedule
end
