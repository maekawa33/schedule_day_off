class Event < ApplicationRecord
  belongs_to :schedule

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :event_title, presence: true
end
