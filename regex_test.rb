#!/usr/bin/env ruby
test_string = "this is [[link1]] not [link-1] and [[other|link2]] [[link3]]"
regex = /\[\[([^\]|]+)\]\]/

# needs to include "link2 "
test_string.scan(regex) { |match|
  puts match
}