class Organizer < ActiveRecord::Base
  has_many :events
  belongs_to :user

  mount_uploader :avatar, AvatarUploader

end
