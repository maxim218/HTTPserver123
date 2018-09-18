require_relative 'session_manager.rb'
require_relative 'give_file.rb'
require_relative 'get_error_404_code.rb'
require_relative 'get_forbidden_403'

def route_query (url, pairs_array, session, method)

  if url == ""
    get_error_404_code (session)
    return
  end

  error_type = 404

  file_name = "." + url
  if file_name[file_name.length - 1] == '/'
    file_name = file_name + "index.html"
    error_type = 403
  end

  file_exists_flag = File.exist? file_name.to_s
  if file_exists_flag
    arr = file_name.split(".")
    type = (arr[arr.length-1] + "").to_s
    if type == "txt"
      give_file url, pairs_array, session, file_name.to_s, "TXT", method
      return
    end
    if type == "html"
      give_file url, pairs_array, session, file_name.to_s, "HTML", method
      return
    end
    if type == "css"
      give_file url, pairs_array, session, file_name.to_s, "CSS", method
      return
    end
    if type == "png"
      give_file url, pairs_array, session, file_name.to_s, "PNG", method
      return
    end
    if type == "gif"
      give_file url, pairs_array, session, file_name.to_s, "GIF", method
      return
    end
    if type == "jpg"
      give_file url, pairs_array, session, file_name.to_s, "JPG", method
      return
    end
    if type == "jpeg"
      give_file url, pairs_array, session, file_name.to_s, "JPG", method
      return
    end
    if type == "js"
      give_file url, pairs_array, session, file_name.to_s, "JS", method
      return
    end
    if type == "swf"
      give_file url, pairs_array, session, file_name.to_s, "SWF", method
      return
    end
  else
    if error_type == 404
      get_error_404_code (session)
    elsif error_type == 403
      get_forbidden_403 (session)
    end
  end
end
