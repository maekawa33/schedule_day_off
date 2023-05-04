class Schedule < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :tries, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :events, dependent: :destroy

  validates :schedule_title, presence: true, length: { maximum: 13 }
  validates :assumed_number_people, presence: true
  validates :get_up_time, presence: true
  validates :sleep_time, presence: true

  enum assumed_number_people: { one_person: 0, two_people: 1, three_people: 2, four_or_more_people: 3 }

  scope :with_tag, ->(tag_name) { joins(:tags).where(tags: { name: tag_name }) }
  scope :created_desc_page, ->(page_name) { order('created_at desc').page(page_name).per(9) }

  def save_with_tags(tag_names)
    ActiveRecord::Base.transaction do
      self.tags = tag_names.map { |name| Tag.find_or_initialize_by(name: name.strip) }
      save!
    end
    true
  rescue StandardError
    false
  end

  def tag_names
    tags.map(&:name).join(' ')
  end

  def self.ransackable_associations(auth_object = nil)
    %w[events]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[schedule_title get_up_time sleep_time assumed_number_people]
  end

  def image_count
    event_images_count = 0
    events.each do |event|
      event_images_count += 1 if event.image.file.present?
    end
    event_images_count
  end

  def sort_events
    today = []
    next_day = []
    events.order(:start_time).each do |event|
      if event.id
        if after_get_up_hour?(event) || after_get_up_minute?(event)
          today.push(event)
        else
          next_day.push(event)
        end
      end
    end
    today + next_day
  end

  def total_price
    total_price = 0
    events.each do |event|
      total_price += event.price if event.price
    end
    total_price
  end

  private

  def after_get_up_hour?(event)
    event.start_time.hour > get_up_time.hour
  end

  def after_get_up_minute?(event)
    event.start_time.hour == get_up_time.hour && event.start_time.min >= get_up_time.min
  end
end
