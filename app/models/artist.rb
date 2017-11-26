class Artist < ActiveRecord::Base
  belongs_to :user

  mount_uploader :avatar, AvatarUploader
  mount_uploader :singing, SingingUploader
  mount_uploader :play_video, PlayVideoUploader

  enum genre: { 'ロック': 1, 'メタル': 2, 'ハードコア': 3, 'アコースティック': 4, 'シンガー': 5 }

end
