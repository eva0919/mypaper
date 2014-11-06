f = File.new('chooseWord.txt','w')
tempHash = Hash.new {  }
File.open("phoneWordScore.txt").each do |line|
	term = line.split(":")
	if term[1].strip.to_f > 10.83
		# f << "#{term[0]} : #{term[1].strip}\n"
		tempHash[term[0]] = term[1].strip.to_f
	end
end

finalHash = tempHash.sort_by { |key,value| value  }

finalHash = Hash[finalHash.to_a.reverse]

finalHash.each do |key,value|
	# puts "#{key}:#{value}"
	f << "#{key} : #{value}\n"
end

f.close