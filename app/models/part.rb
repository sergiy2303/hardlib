class Part < ActiveRecord::Base
  belongs_to :chapter
  belongs_to :user
  has_many :shares, as: :document, dependent: :destroy
end
