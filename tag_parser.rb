Tag = Struct.new(:type, :classes, :id, :name)

class TagParser

  def initialize(html_string)
    @html_string = html_string
    @REGEX_CLASS = /(class=['|"].*['|"]+)/
    @REGEX_ID = /(id=['|"].*['|"])/
    @REGEX_NAME = /(name=['|"].*['|"])/

    @REGEX_TAGS_WITH_ATTRIBUTES = /(<\/?[^>]+['|"].*?['|"]>)/
    @REGEX_TAGS = /(<\/?[A-z0-9]+)|( name=['|"].*?['|"])|( class=['|"].*?['|"]+)|( id=['|"].*?['|"])/
    #@REGEX_TAGS = /(<\/?[A-z0-9]+>)|(<\/?[A-z0-9]+ name=['|"].*?['|"])|(<\/?[A-z0-9]+ class=['|"].*?['|"]+)|(<\/?[A-z0-9]+ id=['|"].*?['|"])/
  end

#----------

  def parse_tag

    tags = @html_string.scan(@REGEX_TAGS)
    tags.flatten!
    tags.compact!
    tag = Tag.new(nil, [], nil, nil)

    tags.each do |e|

      if e.start_with?("<")
        tag.type = e.gsub("<", "")
      elsif e.start_with?("class") || e.start_with?(" class")
        tag.classes = e.gsub("class=", "").split
      elsif e.start_with?("id") || e.start_with?(" id")
        tag.id = e.gsub("id=", "").gsub(" ", "")
      elsif e.start_with?("name") || e.start_with?(" name")
        tag.name = e.gsub("name=", "").gsub(" ", "")
      end
    end
    p tag.type
    p tag.classes
    p tag.id
    p tag.name

  end

#----------


end


tp = TagParser.new("<p class='foo bar' id='baz' name='nombre'>")
=begin
tp = TagParser.new("<html>
  <head>
    <title>
      This is a test page
    </title>
  </head>
  <body>
    <div class='top-div'>
      I'm an outer div!!!
      <div class='inner-div'>
        I'm an inner div!!! I might just <em>emphasize</em> some text.
      </div>
      I am EVEN MORE TEXT for the SAME div!!!
    </div>
    <main id='main-area' name='awesomeness'>
      <header class='super-header'>
        <h1 class='emphasized'>
          Welcome to the test doc!
        </h1>
        <h2>
          This document contains data
        </h2>
      </header>
      <ul>
        Here is the data:
        <li>Four list items</li>
        <li class='bold funky important'>One unordered list</li>
        <li>One h1</li>
        <li>One h2</li>
        <li>One header</li>
        <li>One main</li>
        <li>One body</li>
        <li>One html</li>
        <li>One title</li>
        <li>One head</li>
        <li>One doctype</li>
        <li>Two divs</li>
        <li>And infinite fun!</li>
      </ul>
    </main>
  </body>
</html>")
=end

tp.parse_tag






#ebd