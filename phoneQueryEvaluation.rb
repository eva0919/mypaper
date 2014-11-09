Lenovo = [5,6,10,11,15,21,22,26,27,28,29,33,34,35,37,39,40,43,44,47,49,51,56,63,64,68,96,97,100]
queryWord = ['smartphone', 'phone', 'iphone', 'high-end', 'samsung', 'handset', 'mobile', 'galaxy', 'devices', 'android', 'tablet']

scoreList =[]
maxIndex = 100

keyword = "lenovo"

(1..maxIndex).each do |i|
	tempScore = 0
	docLength = 0.0 
	File.open("./#{keyword}/#{keyword}-#{i}.txt").each do |line|
		if line.include?("<title:>") || line.include?("<Content:>") || line.include?("<Date:>")
			next
		end
		
		line = line.gsub(/[,.!:?<>\[\]~"]/, '');
		line.split(' ').each do |word|
			docLength += 1
			if queryWord.include?(word)
				tempScore += 1
			end
		end
	end
	scoreList << tempScore / docLength
end

recallList = []

scoreList.each_index do |index|
	# puts "#{index+1} -> #{scoreList[index]} \n"
	if scoreList[index] > 0.01
		recallList << index+1
	end
end

recall = 0.0 
# precisious = 0

recallList.each do |value|
	if Lenovo.include?(value)
		recall += 1
	end
end 

puts "recall -> #{recall / Lenovo.size}\n"
puts "precisious -> #{recall / recallList.size}\n"