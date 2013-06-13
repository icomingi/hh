filename = ARGV.first
prompt = "> "

txt = File.open(filename)
puts txt.read()
txt.close()

puts "Please specify a file to open..."
print prompt
another_filename = STDIN.gets.chomp()

another_file = File.open(another_filename)
puts another_file.read()
another_file.close()
