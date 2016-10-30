class AddRepititionsToSequences < ActiveRecord::Migration
  def change
    add_column :sequences, :repititions, :integer
  end
end
