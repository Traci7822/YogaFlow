class CreateJoinTableSequencesPoses < ActiveRecord::Migration
  def change
    create_table :sequence_poses do |t|
      t.integer :sequence_id
      t.integer :pose_id
    end
  end
end
