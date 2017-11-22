class Event < ActiveRecord::Base
  belongs_to :organizer

  mount_uploader :image, ImageUploader
end
