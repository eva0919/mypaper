

url = ARGV[0].to_s

f = File.new("#{url}-write.txt",'w')
isEnd = false
number = 0 
File.open("#{url}.txt").each do |line|


	if line[0] == "\n"
		if isEnd
			f << "<@End News@>\n\n"
			number += 1
		end

		isEnd = false
		next
	end

	isEnd = false

	if line.include?("Document ")
		isEnd = true
	end
	f << line
end
f.close

puts "News Number : #{number}\n"
