require 'socket'
require 'uri'
require 'etc'
require_relative 'router.rb'
require_relative 'pair.rb'
require_relative 'session_manager.rb'
require_relative 'bad_method'
require_relative 'folder_list_control'
require_relative 'get_forbidden_403'
require_relative 'write_line'
require_relative 'files_manager.rb'
require_relative 'allow_write'
require_relative 'config_reader.rb'

user_login = Etc.getlogin
document_root = config_reader
if document_root != ""
  document_root = "/home/" + user_login + document_root
else
  document_root = "."
end
write_line
print "Root: " + document_root.to_s + "\n"

CLONES_NUMBER = 1
PORT_NUMBER = 80

# **********************************************
# **********************************************

server = TCPServer.new PORT_NUMBER.to_i
server.listen 1000

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
  if allow_write
    print "-------------------------------------" + "\n"
    print "PID: " + Process.pid.to_s + "\n"
  end

  session_gets_string = session.gets

  if session_gets_string
    arr = session_gets_string.split(" ")

    if allow_write
      print "Arr: " + arr.to_s + "\n"
    end

    method = arr[0].to_s
    url = document_root.to_s + arr[1].to_s

    method = method.upcase

    if method != "GET" && method != "HEAD"
      bad_method (session)
      session.close
    else
      pairs_array = Array.new

      if allow_write
        print "Method: " + method + "\n"
        print "Url: " + url + "\n"
        print "Variables: " + "\n"
      end

      if url.split("?").length > 1
        mass = url.split("?")[1].split("&")
        n = mass.length
        (0...n).each {|i|
          pair = mass[i]
          a = pair.to_s.split"="
          k = a[0].to_s
          v = a[1].to_s
          if allow_write
            print "Key: " + k + "   Value: " + v + "\n"
          end
          pair_obj = Pair.new
          pair_obj.init_fields(k,v)
          pairs_array.push(pair_obj)
        }
      else
        if allow_write
          print "Url do not have variables" + "\n"
        end
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
  else
    if allow_write
      print "Session is NULL problem !!!" + "\n"
    end
  end
end
