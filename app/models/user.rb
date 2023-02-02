class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :schedules, dependent: :destroy
  has_many :favorites, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :name, presence: true, length: { minimum: 3, maximum: 20 }
  validates :email, uniqueness: true, presence: true

  enum role: {
    general: 0,
    admin: 1
  }
  def already_favorited?(schedule)
    favorites.exists?(schedule_id: schedule.id)
  end
end
