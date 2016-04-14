class Share < ActiveRecord::Base
  belongs_to :user
  belongs_to :document, polymorphic: true

  def self.projects
    where(document_type: Project).all
  end

  def self.parts
    where(document_type: Part).all
  end
end
