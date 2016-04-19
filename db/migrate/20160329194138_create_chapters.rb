class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :title
      t.references :project, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
