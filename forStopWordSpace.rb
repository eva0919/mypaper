f = File.new("stopWordList.txt",'w')
File.open("stopword.txt").each do | line |
	if line.size > 1
		f << line
    end
end
f.close