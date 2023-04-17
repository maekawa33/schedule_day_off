class Event < ApplicationRecord
  belongs_to :schedule

  mount_uploader :image, ImageUploader

  validates :start_time, presence: true
  validates :event_title, presence: true, length: { maximum: 18 }
  validate :start_time_sleep_validate
  validate :end_time_sleep_validate, if: -> { end_time.present? }

  def self.ransackable_attributes(auth_object = nil)
    %w[event_title comment]
  end

  def start_time_sleep_validate
    schedule = Schedule.find(schedule_id)
    errors.add(:base, '寝ている時間です') if sleep_time?(schedule, start_time)
  end

  def end_time_sleep_validate
    schedule = Schedule.find(schedule_id)
    errors.add(:base, '寝ている時間です') if sleep_time?(schedule, end_time)
  end

  private

  def sleep_time?(schedule, time)
    if schedule.get_up_time < schedule.sleep_time
      schedule.get_up_time >= time || time >= schedule.sleep_time
    elsif schedule.get_up_time > schedule.sleep_time
      schedule.sleep_time <= time && time <= schedule.get_up_time
    end
  end
end
