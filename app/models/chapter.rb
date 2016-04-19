class Chapter < ActiveRecord::Base
  belongs_to :project
  has_many :parts
  belongs_to :user
end
