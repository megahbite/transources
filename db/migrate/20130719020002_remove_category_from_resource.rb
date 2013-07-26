class RemoveCategoryFromResource < ActiveRecord::Migration
  def up
    remove_column :resources, :category
  end

  def down
    add_column :resources, :category, :string
  end
end
