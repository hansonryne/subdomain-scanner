class CreateComparisons < ActiveRecord::Migration[5.2]
  def change
    create_table :comparisons do |t|
      t.integer :comparer_id
      t.integer :compared_id

      t.timestamps
    end
    add_index :comparisons, :comparer_id
    add_index :comparisons, :compared_id
    add_index :comparisons, [:comparer_id, :compared_id], unique: true
  end
end
