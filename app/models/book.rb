class Book < ActiveRecord::Base
  belongs_to :user
  mount_uploader :attachment, AttachmentUploader
  mount_uploader :thumbnail, ThumbnailUploader
  validates :title, presence: true, length: { minimum: 2 }
  validates :pages, :year, numericality: true, presence: true
  validates :year, length: { is: 4 }
  validates :attachment, presence: { message: 'Please choose your book' }
end
