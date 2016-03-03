class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title, default: "", null: false

      t.timestamps null: false
    end

    create_table :books_categories, id: false do |t|
      t.belongs_to :book, index: true
      t.belongs_to :category, index: true
    end
  end
end
