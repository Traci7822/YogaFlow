class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :sequences, :length, :number_of_poses
  end
end
