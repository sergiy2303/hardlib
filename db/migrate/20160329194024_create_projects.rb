class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, null: false, default: ""
      t.string :description, default: ""
      t.boolean :public, null: false, default: false
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
