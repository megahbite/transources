class AddLatAndLongToResource < ActiveRecord::Migration
  def change
    add_column :resources, :lat, :float
    add_column :resources, :long, :float
  end
end
