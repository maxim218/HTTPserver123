def route_query (url, pairs_array, session)
  if url == "/httptest/dir2/"
    f = open "./httptest/dir2/index.html"
    f_content = f.read
    f.close
    session.print f_content
  end
end
