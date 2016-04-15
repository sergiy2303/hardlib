class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :books
  has_many :projects
  has_many :shares
  has_many :foreign_shares, class_name: :Share, foreign_key: :sharee_id

  validates :first_name, :last_name, presence: true
end
