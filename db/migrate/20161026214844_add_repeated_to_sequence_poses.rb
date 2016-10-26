class AddRepeatedToSequencePoses < ActiveRecord::Migration
  def change
    add_column :sequence_poses, :repeated, :boolean
  end
end
