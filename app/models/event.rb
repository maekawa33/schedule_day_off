class Event < ApplicationRecord
  belongs_to :schedule

  mount_uploader :image, ImageUploader

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :event_title, presence: true, length: { maximum: 18 }

  validate :sleep_time_validate, unless: -> { start_time.blank? && end_time.blank?}
  def sleep_time_validate

    schedule = Schedule.find(schedule_id)

    if schedule.get_up_time < schedule.sleep_time
      unless schedule.get_up_time <= start_time && start_time <= schedule.sleep_time
        errors.add(:base, '寝ている時間です')
      end
    elsif schedule.get_up_time > schedule.sleep_time
      if schedule.sleep_time <= start_time && start_time <= schedule.get_up_time
        errors.add(:base, '寝ている時間です')
      end
    end

    if schedule.get_up_time < schedule.sleep_time
      unless schedule.get_up_time <= end_time && end_time <= schedule.sleep_time
        errors.add(:base, '寝ている時間です')
      end
    elsif schedule.get_up_time > schedule.sleep_time
      if schedule.sleep_time <= end_time && end_time <= schedule.get_up_time
        errors.add(:base, '寝ている時間です')
      end
    end
  end
end
