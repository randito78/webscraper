require 'open-uri'
require 'uri'

def is_url(scanned_url)
	checker = scanned_url.to_s.scan(/http.*(.com|.org|.net|.edu|.gov)/)
	if checker.size>0
		return true
	else
		return false
	end
end

def is_img(scanned_url)
	checker = scanned_url.to_s.scan(/.*(\.png|\.img|\.jpg|\.gif|\.ico|\.tif|\.rss|css|ssl|.php|.svg|.html|.jpeg|\.xml|\.bundle)/)
	if checker.size>0
		return true
	else
		return false
	end
end

def is_array(x)
	#puts "original value for is_array #{x}"
	if x.is_a?(Array)
		#puts x
		x = x[0]
		is_array(x)
	else
		$lastdearrayedurl = x
		return x

	end
end
$y = ""
$laste = ""

$checkerarray = Array.new
j=0
i=0

#puts "Give me a URL"
#my_url = gets.chomp
$my_url = "https://twitter.com"
$opened_url = open($my_url){|x| x.read}
$url_link = $opened_url.scan(/a href="(.*?)"/)
url_title = $opened_url.scan(/<title>(.*?)<\/title>/)
current_url = is_array($url_link[j])
current_url = URI.join( URI($my_url), URI(current_url)).to_s
puts current_url
$checkerarray.push(URI(current_url).host + URI(current_url).path)
puts url_title
puts " "
$email = []
		$email << $opened_url.scan(/\w+@\w+.[A-z]+.[A-z]{2,4}/)
		#puts $email
		#scheme

#while $checkerarray.size < 100 do
while i < 1080

	#if $url_link.size < 1
		#puts "not a valid link, we need to go back!"
			#$url_link = $last_url
			#i += 1
	#end
current_url = is_array($url_link[j])

	puts i
	if current_url == nil
		current_url = $last_url
		"puts we need a fix here if I show up"
		#j += 1
	end
	current_url = is_array(current_url)
	puts "current_url :: #{current_url}"

		begin
	current_url = URI.join( URI($my_url), URI(current_url)).to_s
			rescue Exception => e
			current_url = $last_url
			puts e.message
			$url_link = $last_url
			j += 1
			puts " "
		end

	#puts is_url(current_url)
	#puts !is_img(current_url)
	#puts !$checkerarray.include?(current_url)


	if is_url(current_url) && !is_img(current_url) && !$checkerarray.include?(URI(current_url).host+URI(current_url).path)
		#puts "in the if statement"
		puts "links gone through: #{i}"
		puts "valid link number: #{$checkerarray.size + 1}"
		i += 1
		#is_array(current_url)
		puts current_url
		if current_url == $last_url
			break
		end
		puts URI(current_url).host+URI(current_url).path
		$checkerarray.push(URI(current_url).host+URI(current_url).path)
		begin
			
		$opened_url = open(current_url){|x| x.read}
		url_title = $opened_url.scan(/<title>(.*?)<\/title>/)
		puts url_title
		$email << $opened_url.scan(/\w+@\w+.[A-z]+.[A-z]{2,4}/)
		#puts $email
		puts " "
		$url_link = $opened_url.scan(/href="(.*?)"/)
		j=0
		i += 1
		#puts $checkerarray
			rescue Exception => e
			#puts e.message
			#if $y == e
			#break
			#end
			#if e.message == laste.message
				#break
			#end
			$url_link = $last_url
			j += 1
			puts " "
			#$y = $laste
			#$laste = e
		end
	else
		#puts "not a valid url or no links on that page"
		i += 1
		j += 1

	end
	$last_url = $url_link
	#puts "array: #{$checkerarray}"
end
puts $checkerarray
puts $email
