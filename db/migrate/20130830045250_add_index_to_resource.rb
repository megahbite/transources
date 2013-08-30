class AddIndexToResource < ActiveRecord::Migration
  def change
    change_table :resources do |t|
      t.index :longlat, spatial: true
    end
  end
end
