class Book < ActiveRecord::Base
  belongs_to :user
  mount_uploader :attachment, AttachmentUploader
  mount_uploader :thumbnail, ThumbnailUploader
  validates :title, presence: true, length: { minimum: 2, maximum: 50 }
  validates :description, length: { maximum: 1000 }
  validates :pages, :year, numericality: true, presence: true
  validates :year, length: { is: 4 }
  validates :attachment, presence: { message: 'Please choose your book' }
  has_and_belongs_to_many :categories
  validates :categories, presence: { message: 'Please choose at least one category'}

  scope :display_index, -> (params) { page(params[:page]).per(12) }
end
