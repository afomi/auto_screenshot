# Sample links.rb file for AutoScreenshot
#
# Important: Be sure to return an Array of URL's

links = []

links << "http://lvh.me/1"
links << "http://lvh.me/2"
# links << "http://lvh.me/3"

(4..10).each do |i|
  links << "http://lvh.me/#{i}"
end

links << "http://dev.lvh.me:3000/login"

$links = links
