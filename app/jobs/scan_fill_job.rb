class ScanFillJob < ApplicationJob
  queue_as :default

  def perform(scan)
    # puts scan.name
    subs = scan.do_subdomain_scan
    subs.each do |s|
      scan.subdomain_records.create!(name: s, scan_id: scan.id)
    end
    if scan.phone_number.present?
      scan.subs_loaded_message(scan.phone_number)
      puts "Message sent"
    end
  end
end
