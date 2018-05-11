class AddDomainToScan < ActiveRecord::Migration[5.2]
  def change
    add_column :scans, :domain, :string
  end
end
