  #!/usr/bin/env ruby
test_string = "this is [[link1]] not [link-1] and [[other|link2]] [[link3]] [[test|this]]"
OPEN_LINK = /\[\[/
CLOSE_LINK = /\]\]/

SIMPLE_LINK = /([^\]|]+)/
TWO_PART_LINK = /[^|]+\|([^\]]+)/

def linkRegex open, link, close
  /#{open}#{link}#{close}/
end

# needs to include "link2 "
test_string.scan(linkRegex OPEN_LINK, SIMPLE_LINK, CLOSE_LINK) { |match|
  puts match
}

puts "---"

test_string.scan(linkRegex OPEN_LINK, TWO_PART_LINK, CLOSE_LINK) { |match|
  puts match
}