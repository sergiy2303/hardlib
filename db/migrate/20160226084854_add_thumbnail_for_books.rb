class AddThumbnailForBooks < ActiveRecord::Migration
  def change
    add_column :books, :thumbnail, :string
  end
end
