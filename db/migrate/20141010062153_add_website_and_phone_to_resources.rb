class AddWebsiteAndPhoneToResources < ActiveRecord::Migration
  def change
    add_column :resources, :website, :string
    add_column :resources, :phone_number, :string
  end
end
