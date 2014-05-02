class CreateBannedIps < ActiveRecord::Migration
  def change
    create_table :banned_ips do |t|
      t.string :ip

      t.timestamps
    end

    add_index :banned_ips, :ip, unique: true
  end
end
