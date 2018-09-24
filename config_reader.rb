require 'etc'
require_relative 'files_manager.rb'

def config_reader
  user_login = Etc.getlogin
  file_name_with_config = "/home/" + user_login.to_s + "/etc/httpd.conf"
  b = File.exist?  file_name_with_config
  not_exists = false
  if b == not_exists
    return ""
  end
  document_root = ""
  config_content = read_file file_name_with_config.to_s
  arr = config_content.to_s.split("\n")
  print "------------------------------------------------" + "\n"
  print "Config File (" + file_name_with_config + ")" + "\n"
  print "------------------------------------------------" + "\n"
  for i in 0...arr.length do
    q = arr[i].to_s
    mass = q.split(" ")
    if mass.length >= 2
      print "Key: " + mass[0].to_s + "     Value: " + mass[1].to_s + "\n"
      if mass[0].to_s == "document_root"
        document_root = mass[1].to_s
      end
    end
  end
  document_root.to_s
end
