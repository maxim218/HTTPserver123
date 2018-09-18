def get_forbidden_403 (session)
  manager = Session_manager.new
  manager.init_fields
  manager.set_http_type_string "HTTP/1.1 403 Forbidden"
  result = manager.get_full_result
  session.print result.to_s
end
