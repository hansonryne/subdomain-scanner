class Scan < ApplicationRecord
  has_many :subdomain_records, dependent: :destroy
  has_many :comparisons, class_name:  "Scan",
                                  foreign_key: "comparer_id",
                                  dependent:   :destroy
  has_many :compared_scans, through: :comparisons, source: :compared
  has_many :reverse_comparisons, class_name:  "Scan",
                                   foreign_key: "compared_id",
                                   dependent:   :destroy
  has_many :comparers, through: :passive_relationships, source: :comparer
  
  validates :name, presence: true
  
    # Follows a scan.
  def follow(other_scan)
    active_relationships.create(followed_id: other_scan.id)
  end

  # Unfollows a scan.
  def unfollow(other_scan)
    active_relationships.find_by(followed_id: other_scan.id).destroy
  end

  # Returns true if the current scan is following the other scan.
  def following?(other_scan)
    following.include?(other_scan)
  end
end
