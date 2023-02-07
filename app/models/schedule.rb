class Schedule < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :events, dependent: :destroy
  accepts_nested_attributes_for :events, reject_if: :all_blank, allow_destroy: true

  validates :schedule_title, presence: true
  validates :assumed_number_people, presence: true
  validates :get_up_time, presence: true
  validates :sleep_time, presence: true
  validate :three_main_events_validate

  def three_main_events_validate
    three_main_events = 3
    main_event_count = 0
    events.each do |a|
      main_event_count += 1 if a.three_main_events == true
    end
    return unless main_event_count != three_main_events

    errors.add(:base, 'メインイベントを三つ選んでください')
  end
end
