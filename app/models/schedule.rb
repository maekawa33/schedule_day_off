class Schedule < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :schedule_title, presence: true, length: { maximum: 13 }
  validates :assumed_number_people, presence: true
  validates :get_up_time, presence: true
  validates :sleep_time, presence: true

  enum assumed_number_people: { one_person: 0, two_people: 1, three_people: 2, four_or_more_people: 3 }

  def sort_events
    today = [] 
    next_day = [] 
    events.order(:start_time).each do |event|
      if event.id
        if event.start_time.hour > get_up_time.hour
          today.push(event)
        elsif event.start_time.hour == get_up_time.hour && event.start_time.min >= get_up_time.min
          today.push(event)
        else
          next_day.push(event)
        end
      end
    end
    sorted_events = today + next_day
    sorted_events
  end
  def total_price
    total_price = 0
    events.each do |event|
      total_price += event.price if event.price
    end
    total_price
  end
end
