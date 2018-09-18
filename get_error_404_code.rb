require_relative 'session_manager.rb'

def get_error_404_code (session)
  manager = Session_manager.new
  manager.init_fields
  manager.set_http_type_string "HTTP/1.1 404"
  result = manager.get_full_result
  session.print result.to_s
end
