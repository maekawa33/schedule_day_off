class Schedule < ApplicationRecord
  belongs_to :user

  has_many :events, dependent: :destroy
  
  validates :schedule_title, presence: true
  validates :assumed_number_people, presence: true
  validate :three_main_events_validate
  def three_main_events_validate
    three_main_events = 3
    main_event_count = 0
    events.each do |a|
      main_event_count += 1 if a.three_main_events == true
    end
    return unless main_event_count != three_main_events

    errors.add(:events, 'main_events fail')
  end
end
