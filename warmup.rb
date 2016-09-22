Tag = Struct.new(:type, :classes, :id, :name)
Tags = Struct.new(:tag, :text, :children, :parent)

def parse_tag(tag_string)

  hmtl_tags = Tag.new("", [], "", "")

  type_regex = /<.([a-z]+)*.?|>/
  class_regex = /class=['|"].+?['|"]/
  id_regex = /(id\s=|id=)\W.+?['|"]/
  name_regex = /(name\s=|name=)\W.+?['|"]/

  type_match = tag_string.match(type_regex)
  type_s = normalize_string(type_match)

  classes_match = tag_string.match(class_regex)
  classes_s = normalize_string(classes_match)
  classes_a = classes_s.split(' ')

  id_match = tag_string.match(id_regex)
  id_s = normalize_string(id_match)

  name_match = tag_string.match(name_regex)
  name_s = normalize_string(name_match)


  hmtl_tags.type = type_s
  hmtl_tags.classes = classes_a
  hmtl_tags.id = id_s
  hmtl_tags.name = name_s

  puts hmtl_tags.type
  puts hmtl_tags.classes
  puts hmtl_tags.id
  puts hmtl_tags.name

  puts type_match
  puts classes_match
  puts id_match
  puts name_match
end

#----------

def normalize_string(tag_string)

  tag_string = tag_string.to_s.gsub("class=", "")
  tag_string = tag_string.gsub("id=", "")
  tag_string = tag_string.gsub("name=", "")
  tag_string = tag_string.gsub("'", "")
  tag_string = tag_string.gsub("<", "")
  tag_string
end

#----------






tag_yanker("<div>\n  div text before\n  <p>\n    p text\n  </p>\n  <div>\n    more div text\n  </div>\n  div text after\n</div>\n")

