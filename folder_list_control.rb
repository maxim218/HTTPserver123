def folder_list_control (url)
  arr = url.to_s.split("/")
  (0...arr.length).each {|i|
    s = arr[i].to_s
    if s == ".."
      return false
    end
  }
  true
end

