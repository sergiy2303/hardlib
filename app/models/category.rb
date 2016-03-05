class Category < ActiveRecord::Base
  has_and_belongs_to_many :books
  validates :title, presence: { message: 'Please add title of category' },
    uniqueness: { message: 'This category already exists' }
end
