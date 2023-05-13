class Try < ApplicationRecord
  belongs_to :user
  belongs_to :schedule

  scope :month_schedules, -> { where(created_at: Time.current.all_month) }
  scope :count_desc, -> { group(:schedule_id).order('count(schedule_id) desc') }
end
