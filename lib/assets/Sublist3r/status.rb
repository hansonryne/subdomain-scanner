require 'open-uri'

File.open("./output.txt", "r") do |file_handle|
  file_handle.each_line do |server|
    begin
      server.chomp!
      data = open("http://#{server}")
      puts data.status[0]
    rescue OpenURI::HTTPError => error
      puts "NOT Available - Error"
    end
  end
end