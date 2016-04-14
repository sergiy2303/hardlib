class Project < ActiveRecord::Base
  belongs_to :user
  has_many :shares, as: :document
  has_many :chapters
end
