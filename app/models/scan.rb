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
  validates :phone_number, format: { with: /\A\d{10}\Z/ }, :allow_blank => true
  


  def do_subdomain_scan
    command = "python " + Rails.root.join('lib', 'assets', 'Sublist3r', 'sublist3r.py').to_s + " "

    outfile = Rails.root.join('lib', 'assets', 'Sublist3r', 'test.txt').to_s

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

    command.concat("-d #{self.name} -o " + outfile)

    # puts "#{command}"
    system "#{command}"

    raw = File.readlines(outfile)
    sub_array = raw.map { |e| e.strip.downcase }.uniq


  end

  def subs_loaded_message(to_number)
    account_sid = ENV['TWILIO_SID']
    auth_token = ENV['TWILIO_TOKEN']
    client = Twilio::REST::Client.new account_sid, auth_token

    from = '7192497988'
    to = "#{to_number}"

    client.messages.create(
        from: from,
        to: to,
        body: "Your scan of #{self.name} is done."
    )
  end
    
  def as_csv
    header = %w(name)
    CSV.generate(headers: true) do |csv|
      csv << %w(Subdomain)
      self.subdomain_records.each do |record|
        csv << header.map{ |attr| record.send(attr) }
      end
    end
  end
    
  def name_and_created_at
    "#{self.name} -- #{self.created_at.strftime("%d %B %y")}"
  end
end
