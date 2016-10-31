class AddJoinsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :sequence_id, :integer
    add_column :comments, :user_id, :integer
  end
end
