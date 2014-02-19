class AddAkismetFieldsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :user_ip, :string
    add_column :comments, :user_agent, :string
    add_column :comments, :referrer, :string
  end
end
