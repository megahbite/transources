class RemoveScoreFromComment < ActiveRecord::Migration
  def change
    remove_column :comments, :score, :integer
  end
end
