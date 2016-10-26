class CreateSequences < ActiveRecord::Migration
  def change
    create_table :sequences do |t|
      t.string :title
      t.integer :length
      t.string :style
      t.string :focus
      t.integer :difficulty

      t.timestamps null: false
    end
  end
end
