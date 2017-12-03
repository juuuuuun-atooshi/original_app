class Organizer < ActiveRecord::Base
  has_many :events
  belongs_to :user

  has_many :concerns, foreign_key:"follower_id", dependent: :destroy
  has_many :reverse_concerns, foreign_key:"followed_id", class_name: "Concern", dependent: :destroy

  has_many :followed_users, through: :concerns, source: :followed
  has_many :followers, through: :reverse_concerns, source: :follower

  mount_uploader :avatar, AvatarUploader


end
