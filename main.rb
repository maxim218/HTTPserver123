require 'socket'

port_number = 5005

server = TCPServer.new port_number

while (session = server.accept)
  arr = session.gets.split(" ")

  method = arr[0].to_s
  url = arr[1].to_s

  print "-------------------------------------" + "\n"
  print "Method: " + method + "\n"
  print "Url: " + url + "\n"

  print "Variables: " + "\n"

  if url.split("?").length > 1
    mass = url.split("?")[1].split("&")
    n = mass.length
    (0...n).each {|i|
      pair = mass[i]
      a = pair.to_s.split"="
      k = a[0].to_s
      v = a[1].to_s
      print "Key: " + k + "   Value: " + v + "\n"
    }
  else
    print "Url do not have variables" + "\n"
  end

  # http type
  session.print "HTTP/1.1 200\r\n"

  # headers
  session.print "Content-Type: text/html\r\n"
  session.print "Cache-Control: no-cache, no-store, must-revalidate\r\n"

  # separator
  session.print "\r\n"

  # answer
  session.print "I am Maxim"

  session.close
end