class Session_manager
  def init_fields
    @http_type_string = ""
    @headers_string = ""
    @body_answer_string = ""
    @method = "GET"
    add_basic_headers
  end

  def set_method (method_string)
    @method = method_string.to_s
  end

  def add_basic_headers
    add_headers_string "Cache-Control: no-cache, no-store, must-revalidate"
    add_headers_string "Server: Maxim-Kolotovkin-Server"
    add_headers_string "Date: #{Time.now}"
    add_headers_string"Connection: keep-alive"
  end

  def set_http_type_string (string_param)
    @http_type_string = string_param.to_s + "\r\n"
  end

  def add_headers_string (string_param)
    @headers_string = @headers_string + string_param.to_s + "\r\n"
  end

  def set_body_answer_string (string_param)
    @body_answer_string = string_param.to_s
  end

  def get_full_result
    full_result_string = ""
    if @method == "GET"
      full_result_string = @http_type_string.to_s + @headers_string.to_s + "\r\n" + @body_answer_string.to_s
    end
    if @method == "HEAD"
      full_result_string = @http_type_string.to_s + @headers_string.to_s
      buffer = ""
      for i in 0...full_result_string.length - 2
        buffer = buffer + full_result_string[i]
      end
      full_result_string = buffer.to_s
      print "Answer:" + "\n"
      print full_result_string
    end
    full_result_string.to_s
  end
end