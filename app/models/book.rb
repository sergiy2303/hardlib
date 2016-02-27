class Book < ActiveRecord::Base
  belongs_to :user
  mount_uploader :attachment, AttachmentUploader
  mount_uploader :thumbnail, ThumbnailUploader
  validates :title, presence: true
end
