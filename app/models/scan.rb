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
    datetime = DateTime.current
    self.filename = datetime.strftime("%Y%m%d%H%Mnmap")
    outfile = self.filename

    command = "nmap "

    case self.speed
    when "1"
      command.concat("-T1 ")
    when "2"
      command.concat("-T2 ")
    when "3"
      command.concat("-T3 ")
    when "4"
      command.concat("-T4 ")
    when "5"
      command.concat("-T5 ")
    else
    end

    if self.ping == "off"
      command.concat("-Pn ")
    end

    if self.fragment == "on"
      command.concat("-f ")
    end

    #if self.zombie == "1"
    #	command.concat("-sI  ")
    #end

    if self.service_version == "on"
      command.concat("-sV ")
    end

    if self.os == "on"
      command.concat("-O ")
    end

    if self.safe == "on"
      command.concat("-sC ")
    end

    if self.vuln == "on"
      command.concat("--script vuln ")
    end

    command.concat("-p #{self.port} #{self.target}")

    #remove the > /dev/null eventually
    system "sudo #{command} -oX #{outfile} > /dev/null"
    system "xsltproc #{outfile} -o public/nmapscans/#{outfile}.html"
    system "rm -rf #{outfile}"

    self.save
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
