class Schedule < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :schedule_title, presence: true, length: { maximum: 13 }
  validates :assumed_number_people, presence: true
  validates :get_up_time, presence: true
  validates :sleep_time, presence: true

  enum assumed_number_people: [ :one_person, :two_people, :three_people, :four_or_more_people ]
  
end
