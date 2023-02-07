class Event < ApplicationRecord
  belongs_to :schedule

  mount_uploader :image, ImageUploader

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :event_title, presence: true, length: { maximum: 10 }
end
