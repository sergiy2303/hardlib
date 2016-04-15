class Share < ActiveRecord::Base
  belongs_to :user
  belongs_to :document, polymorphic: true
  belongs_to :sharee, class_name: :User

  scope :project_shares, -> { where(document_type: Project) }
  scope :part_shares, -> { where(document_type: Part) }
  scope :projects, -> { Project.where(id: project_shares.map(&:document_id)) }
  scope :parts, -> { Part.where(id: project_shares.map(&:document_id)) }

  validate :share_self, on: :create
  validates :document_id, :document_type, presence: { message: 'Invalid share. Please try again.' }
  validates :sharee_id, presence: { message: 'This user does not exist.' },
                        uniqueness: { scope: [:document_id, :document_type], message: 'You have already shared this item.' }

  private

  def share_self
    errors.add(:sharee_id, "You can't share item self.") if user_id == sharee_id
  end
end
