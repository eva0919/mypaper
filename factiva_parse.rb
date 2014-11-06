# require 'nokogiri'
# require 'open-uri'
# require 'openssl'
require 'fileutils'



url = ARGV[0].to_s
# url = 'Factiva-20141003-0034-write.txt'
# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
# doc = Nokogiri::HTML( File.open(url) )
# keyword = 'xiaomi'
keyword = ARGV[1].to_s
index = 1
isDate = false
isTitle = true
isContent = false
isEnd = false
isSpacialContent = false
f = File.new('temp.txt','w')
tempText = ''
title = ''
date = ''
tempContent = ''

unless File.exist?("./#{keyword}")
	puts "hi"
	FileUtils.mkdir_p keyword
end
File.open("#{url}.txt").each do |line|
	if isTitle && line.include?("words") && line.include?("words,")
		section = line.split(", ")
		tempindex = 0 
		targetIndex = 0 
		section.each do |t|
			if t.include?("words")
				targetIndex = tempindex
			end
			tempindex += 1
		end
		title = tempText
		isTitle = false
		isDate = false
		isSpacialContent = true
		date = section[targetIndex-1]
		# p section
		f = File.new("./#{keyword}/#{keyword}-#{index}.txt",'w')
		f << "<title:>#{title.strip}\n"
		title = ''
		tempText = ''
		f << "<Date:>#{date.strip}\n"
		data = ''
		f << "<Content:>\n"
		next
	elsif isTitle && line.include?("words")
		title = tempText
		isTitle = false
		isDate =  true
		f = File.new("./#{keyword}/#{keyword}-#{index}.txt",'w')
		f << "<title:>#{title.strip}\n"
		title = ''
		tempText = ''
		next
	end
	if isTitle
		unless line.include?("By ")
			tempText += line
		end
		next
	end

	if isDate
		isDate = false
		date = line
		f << "<Date:>#{date.strip}\n"
		data = ''
		next
	end
	if isSpacialContent
		if line.include?("Document ")
			isEnd = true
			tempContent = line
			next
		elsif isEnd && line.include?("<@End News@>")
			isDate = false
			isTitle = true
			isContent = false
			isSpacialContent = false
			isEnd = false
			index += 1
			next
		elsif isEnd
			f << tempContent
			f << line
			isEnd = false
		else
			f << line
		end
	else
		if !isContent && line.include?("Copyright ")
			isContent = true
			f << "<Content:>\n"
			next
		end

		if isContent
			if line.include?("Document ")
				isEnd = true
				tempContent = line
				next
			elsif isEnd && line.include?("<@End News@>")
				isDate = false
				isTitle = true
				isContent = false
				isSpacialContent = false
				isEnd = false
				index += 1
				next
			elsif isEnd
				f << tempContent
				f << line
				isEnd = false
			else
				f << line
			end
		end
	end
	# puts line
	# f << line
end
f.close
puts "Exec #{index} News ...\n"
# puts doc