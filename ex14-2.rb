user, wish = ARGV
prompt = "请说: "

puts "#{user}, 你好！我是{$0}."
puts "我想问你几个问题."
puts "#{user}, 你喜欢我吗?"
print prompt
likes = STDIN.gets.chomp()

puts "#{user}, 你住在哪里?"
print prompt
lives = STDIN.gets.chomp()

puts "你平时用什么电脑?"
print prompt
computer = STDIN.gets.chomp()

puts <<MESSAGE
好的，#{user}, 关于喜欢我，你说#{likes}。
你住在#{lives}。
你平时用#{computer}电脑。
祝你#{wish}!
MESSAGE
