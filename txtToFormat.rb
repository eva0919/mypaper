

url = ARGV[0].to_s

f = File.new("#{url}-write.txt",'w')
isEnd = false

File.open("#{url}.txt").each do |line|


	if line[0] == "\n"
		if isEnd
			f << "<@End News@>"
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
