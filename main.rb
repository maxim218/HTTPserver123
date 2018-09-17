require 'socket'
require_relative 'router.rb'
require_relative 'pair.rb'

port_number = 5005
server = TCPServer.new port_number

while (session = server.accept)
  arr = session.gets.split(" ")

  method = arr[0].to_s
  url = arr[1].to_s

  pairs_array = Array.new

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
      pair_obj = Pair.new
      pair_obj.init_fields(k,v)
      pairs_array.push(pair_obj)
    }
  else
    print "Url do not have variables" + "\n"
  end

  route_query url, pairs_array, session

  session.close
end