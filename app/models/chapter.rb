class Chapter < ActiveRecord::Base
  belongs_to :project
  has_many :parts, dependent: :destroy
  belongs_to :user
end
