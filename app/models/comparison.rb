class Comparison < ApplicationRecord
  belongs_to :comparer, class_name: 'Scan'
  belongs_to :compared, class_name: 'Scan'
  
  validates :comparer_id, presence: true
  validates :compared_id, presence: true
  
  validates :compared_id, :uniqueness => {:scope => :comparer_id}
  validate :check_same_scan
  validate :check_duplicate
  
  def check_same_scan
    errors[:base] << "Can't compare a scan to itself " if compared_id == comparer_id
  end
  
  def check_duplicate
    if Comparison.where(compared_id: comparer_id, comparer_id: compared_id).present?
      errors[:base] << "This comparison already exists"
    end
  end
  
  def get_duplicate(current_comparison)
    Comparison.where(compared_id: current_comparison.comparer_id, comparer_id: current_comparison.compared_id).pluck(:id)
  end
  
  def scan_names
    [comparer.name, compared.name]
  end
end
