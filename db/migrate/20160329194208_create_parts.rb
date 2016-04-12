class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :title, null: false, default: ""
      t.string :body, null: false, default: ""
      t.references :chapter, index: true

      t.timestamps null: false
    end
  end
end
