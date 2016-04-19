class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :sharee_id
      t.references :document, index: true, polymorphic: true
      t.references :user, index: true
      t.timestamps null: false
    end
  end
end
