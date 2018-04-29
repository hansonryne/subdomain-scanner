class Comparison < ApplicationRecord
  belongs_to :comparer, class_name: 'Scan'
  belongs_to :compared, class_name: 'Scan'
  
  validates :comparer_id, presence: true
  validates :compared_id, presence: true
  
  validate :check_same_scan
  validate :check_duplicate
  
  def check_same_scan
    errors[:base] << "Can't compare a scan to itself " if compared_id == comparer_id
  end
  
  def check_duplicate
    if Comparison.where(compared_id: comparer_id, comparer_id: compared_id).present? or Comparison.where(compared_id: compared_id, comparer_id: comparer_id).present?
      errors[:base] << "This comparison already exists"
    end
  end
  
  def get_duplicate
    if Comparison.where(compared_id: comparer_id, comparer_id: compared_id).present?
      Comparison.where(compared_id: comparer_id, comparer_id: compared_id).pluck(:id)
    else
      Comparison.where(compared_id: compared_id, comparer_id: comparer_id).pluck(:id)
    end
  end
  
  def find_common_domains
    common_domains = subdomain_records_names[:comparer] & subdomain_records_names[:compared]
  end
  
  def find_unique_domains
    unique_domains_hash = { :unique_comparer => subdomain_records_names[:comparer] - subdomain_records_names[:compared], :unique_compared => subdomain_records_names[:compared] - subdomain_records_names[:comparer] }
  end
  
  def scan_names
    [comparer.name, compared.name]
  end
  
  def subdomain_records_names
    compared_names = []
    compared.subdomain_records.each do |r|
      compared_names << r.name
    end
    comparer_names = []
    comparer.subdomain_records.each do |r|
      comparer_names << r.name
    end
    subdomain_records_names_hash = { :compared => compared_names, :comparer => comparer_names }
  end
end
