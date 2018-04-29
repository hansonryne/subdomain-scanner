class AddBruteAndThreadsToScan < ActiveRecord::Migration[5.2]
  def change
    add_column :scans, :brute, :string
    add_column :scans, :threads, :integer
  end
end
