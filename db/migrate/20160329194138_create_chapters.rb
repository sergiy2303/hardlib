class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :title, null: false, default: ""
      t.references :project, index: true

      t.timestamps null: false
    end
  end
end
