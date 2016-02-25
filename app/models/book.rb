class Book < ActiveRecord::Base
  belongs_to :user
  mount_uploader :attachment, AttachmentUploader
  validates :title, presence: true
end
