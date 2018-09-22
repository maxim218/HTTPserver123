require_relative 'session_manager.rb'
require_relative 'allow_write'

def give_file (url, pairs_array, session, file_name, file_type, method)
  f = open file_name.to_s
  f_content = f.read
  f_length = File.size(file_name).to_s
  f.close
  manager = Session_manager.new
  manager.init_fields
  if method == "HEAD"
    manager.set_method "HEAD"
  end
  manager.set_http_type_string "HTTP/1.1 200 OK"
  manager.set_body_answer_string f_content
  if file_type == "TXT"
    manager.add_headers_string "Content-Type: text/plain"
  end
  if file_type == "HTML"
    manager.add_headers_string "Content-Type: text/html"
  end
  if file_type == "CSS"
    manager.add_headers_string "Content-Type: text/css"
  end
  if file_type == "PNG"
    manager.add_headers_string "Content-Type: image/png"
  end
  if file_type == "GIF"
    manager.add_headers_string "Content-Type: image/gif"
  end
  if file_type == "JPG"
    manager.add_headers_string "Content-Type: image/jpeg"
  end
  if file_type == "JS"
    manager.add_headers_string "Content-Type: text/javascript"
  end
  if file_type == "SWF"
    manager.add_headers_string "Content-Type: application/x-shockwave-flash"
  end
  manager.add_headers_string "Content-Length: " + f_length.to_s
  if allow_write
    print "Size: " + f_length.to_s + "\n"
  end
  result = manager.get_full_result
  session.print result.to_s
end