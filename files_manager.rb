def write_file (file_name, content)
  f = File.new file_name.to_s, "w"
  f.write content.to_s
  f.close
end

def read_file (file_name)
  f = open file_name.to_s
  content = f.read.to_s
  f.close
  content.to_s
end
