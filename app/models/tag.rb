class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tagged_schedules, through: :taggings, source: :schedule

  validates :name, presence: true, uniqueness: true
end
