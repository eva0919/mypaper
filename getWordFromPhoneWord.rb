f = File.new('chooseWord.txt','w')

File.open("phoneWordScore.txt").each do |line|
	term = line.split(":")
	if term[1].strip.to_f > 10.83
		f << "#{term[0]} : #{term[1].strip}\n"
	end
end

f.close