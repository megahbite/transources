class AddLatLongToResource < ActiveRecord::Migration
  def change
    add_column :resources, :longlat, :point, geographic: true
  end
end
