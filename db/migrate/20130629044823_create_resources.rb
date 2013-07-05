class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :title
      t.text :description
      t.string :category
      t.string :address_line_1
      t.string :address_line_2
      t.string :town
      t.string :country

      t.timestamps
    end
  end
end
