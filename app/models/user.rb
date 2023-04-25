class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :schedules, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tries, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  validates :password, length: { minimum: 3 }, if: -> { default? && (new_record? || changes[:crypted_password]) }
  validates :password, confirmation: true, if: -> { default? && (new_record? || changes[:crypted_password]) }
  validates :password_confirmation, presence: true, if: -> { default? && (new_record? || changes[:crypted_password]) }
  validates :reset_password_token, uniqueness: true, allow_nil: true

  validates :name, presence: true, length: { minimum: 3, maximum: 20 }
  validates :email, uniqueness: { scope: :login_type }, presence: true
  validates :login_type, presence: true
  enum role: {
    general: 0,
    guest: 1,
    admin: 2
  }

  enum login_type: {
    default: 0,
    google: 1
  }

  def already_favorited?(schedule)
    favorites.exists?(schedule_id: schedule.id)
  end

  def own?(object)
    id == object.user_id
  end

  def mine?(object)
    id == object.id
  end
end
