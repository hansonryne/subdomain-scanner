class SubdomainRecord < ApplicationRecord
  belongs_to :scan
  
  validates :name, :scan_id, presence: true
  validates :name, uniqueness: { scope: :scan_id, message: "Scan records must be unique within scans" }
  
end
