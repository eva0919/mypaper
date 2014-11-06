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
f = File.new('temp.txt','w')
tempText = ''
title = ''
date = ''
unless File.exist?("./#{keyword}")
	puts "hi"
	FileUtils.mkdir_p keyword
end
File.open("#{url}.txt").each do |line|
	if isTitle && line.include?("words") 
		title = tempText
		isTitle = false
		isDate =  true
		f = File.new("./#{keyword}/#{keyword}-#{index}.txt",'w')
		f << "<title:>#{title}"
		next
	end
	if isTitle
		tempText = line
		next
	end

	if isDate
		isDate = false
		date = line
		f << "<Date:>#{date}"
		next
	end

	if !isContent && line.include?("Copyright ")
		isContent = true
		f << "<Content:>\n"
		next
	end

	if isContent
		if line.include?("Document ")
			isDate = false
			isTitle = true
			isContent = false
			index += 1
			next
		else
			f << line
		end
	end
	# puts line
	# f << line
end
# f.close
# puts doc