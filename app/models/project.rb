class Project < ActiveRecord::Base
  belongs_to :user
  has_many :shares, as: :document
  has_many :chapters

  def share_for(user)
    shares.create(sharee_id: user&.id, user_id: self.user.id)
  end
end
