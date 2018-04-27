class CreateSubdomainRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :subdomain_records do |t|
      t.string :name
      t.integer :scan_id
      
      t.timestamps
    end
  end
end
