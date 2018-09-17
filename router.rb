require_relative 'session_manager.rb'

def give_file (url, pairs_array, session, file_name, file_type)
  f = open file_name.to_s
  f_content = f.read
  f_length = File.size(file_name).to_s
  f.close
  manager = Session_manager.new
  manager.init_fields
  manager.set_http_type_string "HTTP/1.1 200"
  manager.set_body_answer_string f_content
  if file_type == "HTML"
    manager.add_headers_string "Content-Type: text/html"
  end
  if file_type == "CSS"
    manager.add_headers_string "Content-Type: text/css"
  end
  if file_type == "PNG"
    manager.add_headers_string "Content-Type: image/png"
  end
  manager.add_headers_string "Content-Length: " + f_length.to_s
  print "Size: " + f_length.to_s + "\n"
  result = manager.get_full_result
  session.print result.to_s
end

def route_query (url, pairs_array, session)
  if url == ""
    manager = Session_manager.new
    manager.init_fields
    manager.set_http_type_string "HTTP/1.1 404"
    result = manager.get_full_result
    session.print result.to_s
    return
  end

  file_name = "." + url
  if file_name[file_name.length - 1] == '/'
    file_name = file_name + "index.html"
  end

  file_exists_flag = File.exist? file_name.to_s
  if file_exists_flag == TRUE
    arr = file_name.split(".")
    type = (arr[arr.length-1] + "").to_s
    if type == "html"
      give_file url, pairs_array, session, file_name.to_s, "HTML"
    end
    if type == "css"
      give_file url, pairs_array, session, file_name.to_s, "CSS"
    end
    if type == "png"
      give_file url, pairs_array, session, file_name.to_s, "PNG"
    end
  end
end
