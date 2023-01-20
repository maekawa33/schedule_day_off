class Schedule < ApplicationRecord
  belongs_to :user

  validates :schedule_title, presence: true
  validates :assumed_number_people, presence: true
end
