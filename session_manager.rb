class Session_manager
  def init_fields
    @http_type_string = ""
    @headers_string = ""
    @body_answer_string = ""
    add_basic_headers
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
    full_result_string = @http_type_string.to_s + @headers_string.to_s + "\r\n" + @body_answer_string.to_s
    full_result_string.to_s
  end
end