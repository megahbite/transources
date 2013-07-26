class CreateCategoriesResourcesJoinTable < ActiveRecord::Migration
  def change
    create_table :categories_resources, id: false do |t|
      t.integer :category_id
      t.integer :resource_id
    end
  end
end
