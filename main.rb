require 'socket'
require 'uri'
require_relative 'router.rb'
require_relative 'pair.rb'
require_relative 'session_manager.rb'
require_relative 'bad_method'
require_relative 'folder_list_control'
require_relative 'get_forbidden_403'
require_relative 'write_line'
require_relative 'files_manager.rb'

CLONES_NUMBER = 2

port_number = 5005
server = TCPServer.new port_number


# **********************************************
# **********************************************
# **********************************************

write_file "count_save_file.txt", 0

main = Process.pid
write_line
print "Main: " + main.to_s + "\n"
write_line

loop do
  count = read_file "count_save_file.txt"
  count = count.to_i
  break if count.to_i == CLONES_NUMBER.to_i
  count = count + 1
  write_file "count_save_file.txt", count.to_s
  Process.fork
end

if Process.pid == main
  print "Me (main)   : " + Process.pid.to_s
  print "\n"
else
  print "Me (clone)  : " + Process.pid.to_s
  print "\n"
end

# **********************************************
# **********************************************
# **********************************************


while (session = server.accept)
  arr = session.gets.split(" ")

  method = arr[0].to_s
  url = arr[1].to_s

  method = method.upcase

  if method != "GET" && method != "HEAD"
    bad_method (session)
    session.close
  else
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

    url = url.split("?")[0].to_s
    url = URI.unescape(url)

    if folder_list_control url
      route_query url, pairs_array, session, method
    else
      get_forbidden_403 session
    end

    session.close
  end
end