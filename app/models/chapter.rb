class Chapter < ActiveRecord::Base
  belongs_to :project
  has_many :parts
end
