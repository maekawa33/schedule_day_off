class Schedule < ApplicationRecord
  belongs_to :user

  validates :schedule_title, presence: true
  validates :assumed_number_people, presence: true
  validate :three_main_events_validate
  def three_main_events_validate
    three_main_events = 3
    main_event_count = 0
    events.each do |a|
      if a.three_main_events == true
        main_event_count += 1
      end
    end
    if main_event_count != three_main_events
      errors.add(:events, "main_events fail")
    end
  end  
end
