class ScanFillJob < ApplicationJob
  queue_as :default

  def perform(scan)
    scan.do_subdomain_scan
  end
end
