class RemoveColumn < ActiveRecord::Migration
  def change
    remove_column :sequences, :style
  end
end
