class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.decimal :value
      t.integer :user_id
      t.integer :resource_id

      t.timestamps
      t.index [:user_id, :resource_id]
    end
  end
end
