class Event < ActiveRecord::Base
  belongs_to :organizer

  mount_uploader :image, ImageUploader

  enum genre:{初ライブデビュー向け！:"1", 新規アーティスト歓迎！:"2", ジャンル縛りライブ！:"3", みんな祭りだオールジャンル！:"4", その他:"5"}

  geocoded_by :address
  after_validation :geocode, if: lambda {|obj| obj.address_changed?}

end
