require "open-uri"

#open("http://www.ruby-lang.org/en") do |w|
open("http://www.google.com") do |w|
#  w.each_line {|line| p line}
  puts w.base_uri
  puts w.charset
  puts w.content_type
  
#  w.methods.each {|m| puts m}
#  puts w.response
#  puts w.expires
#  puts w.server
end
