class Scan < ApplicationRecord
  has_many :subdomain_records, dependent: :destroy
  has_many :comparisons, class_name:  "Comparison",
                                  foreign_key: "comparer_id",
                                  dependent:   :destroy
  has_many :compared_scans, through: :comparisons, source: :compared
  has_many :reverse_comparisons, class_name:  "Comparison",
                                   foreign_key: "compared_id",
                                   dependent:   :destroy
  has_many :comparers, through: :reverse_comparisons, source: :comparer
  
  validates :name, presence: true, format: { with: /\A(?!:\/\/)([a-zA-Z0-9-_]+\.)*[a-zA-Z0-9][a-zA-Z0-9-_]+\.[a-zA-Z]{2,11}?\Z/i, message: 'Please enter a valid domain name.' }
  


  def do_subdomain_scan
    command = "python " + Rails.root.join('lib', 'assets', 'Sublist3r', 'sublist3r.py').to_s + " "

    case self.threads
    when 16
      command.concat("-t 16 ")
    when 32
      command.concat("-t 32 ")
    when 48
      command.concat("-t 48 ")
    when 64
      command.concat("-t 64 ")
    else
    end

    if self.brute == "on"
      command.concat("-b ")
    end

    command.concat("-d #{:name} -o " + Rails.root.join('lib', 'assets', 'Sublist3r', 'test.txt').to_s)
    
    puts command


#     #remove the > /dev/null eventually
#     system "sudo #{command} -oX #{outfile} > /dev/null"
#     system "xsltproc #{outfile} -o public/nmapscans/#{outfile}.html"
#     system "rm -rf #{outfile}"

#     self.save
  end


=begin
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
=end
end
