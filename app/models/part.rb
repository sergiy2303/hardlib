class Part < ActiveRecord::Base
  belongs_to :chapter
  has_many :shares, as: :document
end
