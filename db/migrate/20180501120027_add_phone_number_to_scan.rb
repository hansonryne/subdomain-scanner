class AddPhoneNumberToScan < ActiveRecord::Migration[5.2]
  def change
    add_column :scans, :phone_number, :string
  end
end
