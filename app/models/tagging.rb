class Tagging < ApplicationRecord
  belongs_to :schedule
  belongs_to :tag
  validates :tag_id, uniqueness: { scope: :schedule_id }
end
