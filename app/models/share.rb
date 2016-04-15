class Share < ActiveRecord::Base
  belongs_to :user
  belongs_to :document, polymorphic: true

  scope :projects, -> { where(document_type: Project).all }
  scope :parts, -> { where(document_type: Part).all }
  scope :find_shares, -> (user_id) { where(sharee_id: user_id).all }
  scope :find_shared_projects, -> (user) { find_shares(user.id).projects.map(&:document) }
  scope :find_shared_parts, -> (user) { find_shares(user.id).parts.map(&:document) }
end
