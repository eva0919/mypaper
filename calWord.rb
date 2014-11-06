wordList = Array.new
phoneWord = Hash.new # tf 
phoneDfWord = Hash.new # df
nonPhoneWord = Hash.new # tf
nonPhoneDfWord = Hash.new # df
stopWordList = Array.new
# label from myself 
Apple = [1,2,4,6,8,12,14,17,19,26,27,32,33,34,39,42,49,52,53,55,62,63,64,71,73,74,75,76,77,82,90]
Samsung = [1,2,4,10,12,13,14,15,17,20,23,26,28,36,40,51,52,53,54,55,56,58,61,64,69,71,73,74,75,78,79,80,82,86,89,94,96,97]

# Load StopWord
puts "Loading StopWord ...\n"
File.open("stopWordList.txt").each do |line|
	stopWordList << line.strip
end
puts "Loading finish ...\n"

# Load apple folder file to get phone word and nonphone word
index = 1
maxIndex = 100
keyword = "apple"
puts "Loading file  ./#{keyword}/#{keyword}-(1~50).txt  ...\n"
while index <= maxIndex 
	isNews = if Apple.include?(index)
		        true
		    else
		    	false
		    end
    print "\r                                                              \r"
    print "Process #{index/maxIndex.to_f * 100} % "
    df_list = Array.new
	File.open("./#{keyword}/#{keyword}-#{index}.txt").each do |line|		
		if line.include?(":>")
			next
		end
		line = line.gsub(/[,.!:?<>\[\]~"]/, '');
		line.split(' ').each do |word|
			word = word.downcase
			unless stopWordList.include?(word)
				unless wordList.include?(word)
					wordList << word
				end

				if isNews
					if phoneWord.has_key?(word)
						phoneWord[word] = phoneWord[word] + 1
					else
						phoneWord[word] = 1 ;
					end

					unless df_list.include?(word)
						df_list << word						
						if phoneDfWord.has_key?(word)
							phoneDfWord[word] = phoneDfWord[word] + 1
						else
							phoneDfWord[word] = 1 ;
						end
					end

			    else
			    	if nonPhoneWord.has_key?(word)
						nonPhoneWord[word] = nonPhoneWord[word] + 1
					else
						nonPhoneWord[word] = 1 ;
					end

					unless df_list.include?(word)
						df_list << word						
						if nonPhoneDfWord.has_key?(word)
							nonPhoneDfWord[word] = nonPhoneDfWord[word] + 1
						else
							nonPhoneDfWord[word] = 1 ;
						end
					end
			    end
			end
		end
	end
	index += 1
end
puts "\r\t"
# Load samsung folder file to get phone word and nonphone word
index = 1
keyword = "samsung"
puts "Loading file  ./#{keyword}/#{keyword}-(1~50).txt  ...\n"
while index <= maxIndex 
	isNews = if Samsung.include?(index)
		        true
		    else
		    	false
		    end
    print "\r                                                              \r"
    print "Process #{index/maxIndex.to_f * 100} % "
    df_list = Array.new 
	File.open("./#{keyword}/#{keyword}-#{index}.txt").each do |line|
		if line.include?(":>")
			next
		end
		line = line.gsub(/[,.!:?<>\[\]~"]/, '');
		line.split(' ').each do |word|
			word = word.downcase
			unless stopWordList.include?(word)
				unless wordList.include?(word)
					wordList << word
				end
				if isNews
					if phoneWord.has_key?(word)
						phoneWord[word] = phoneWord[word] + 1
					else
						phoneWord[word] = 1 ;
					end

					unless df_list.include?(word)
						df_list << word						
						if phoneDfWord.has_key?(word)
							phoneDfWord[word] = phoneDfWord[word] + 1
						else
							phoneDfWord[word] = 1 ;
						end
					end
			    else
			    	if nonPhoneWord.has_key?(word)
						nonPhoneWord[word] = nonPhoneWord[word] + 1
					else
						nonPhoneWord[word] = 1 ;
					end

					unless df_list.include?(word)
						df_list << word						
						if nonPhoneDfWord.has_key?(word)
							nonPhoneDfWord[word] = nonPhoneDfWord[word] + 1
						else
							nonPhoneDfWord[word] = 1 ;
						end
					end
			    end
			end
		end
	end
	index += 1
end
puts "\r\t"
f = File.new('wordList.txt','w')
wordList.each do |word|
	f << "#{word}\n"
end

f = File.new('phoneDfWord.txt','w')
phoneDfWord.each do |key,value|
	f << "#{key}:#{value}\n"
end
f = File.new('phoneWord.txt','w')
phoneWord.each do |key,value|
	f << "#{key}:#{value}\n"
end
f = File.new('nonPhoneWord.txt','w')
nonPhoneWord.each do |key,value|
	f << "#{key}:#{value}\n"
end
f = File.new('nonPhoneDfWord.txt','w')
nonPhoneDfWord.each do |key,value|
	f << "#{key}:#{value}\n"
end

# Cal word score about phone
puts "Caling word score about phone  ...\n"
docSize = 100.0
wordSize = wordList.size * 1.0
f = File.new('phoneWordScore.txt','w')
index = 1
wordList.each do |word|
	print "\r                                                              \r"
    print "Process #{ (index/wordSize * 100).to_i } % "
	phoneTf = if phoneWord.has_key?(word)
				 1 + (phoneWord[word] / wordList.size)
			  else
				 1
			  end
	phoneDf = if phoneDfWord.has_key?(word)
				 1 + (phoneDfWord[word] / docSize)
			  else
				 1
			  end
    nonPhoneDf = if nonPhoneDfWord.has_key?(word)
				 1 + (nonPhoneDfWord[word] / docSize)
			  else
				 1
			  end
    nonPhoneTf = if nonPhoneWord.has_key?(word)
				 1 + (nonPhoneWord[word] / wordList.size)
			  else
				 1
			  end
	f << "#{word} : #{ phoneTf/nonPhoneTf + phoneDf/nonPhoneDf }\n"
	index += 1
end
f.close
puts "\r\t"
puts "\n\n--------------------\n\n"
puts "  Program end ...\n"
puts "\n--------------------\n"