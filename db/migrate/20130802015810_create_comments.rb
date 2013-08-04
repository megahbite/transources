class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :text
      t.integer :score
      t.integer :resource_id

      t.timestamps
    end
  end
end
