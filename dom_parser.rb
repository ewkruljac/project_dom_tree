Tree = Struct.new(:type, :children, :parent, :closer)
Tag = Struct.new(:type, :classes, :id, :name)

class DOMParser

  def initialize(html_string)
    @html_string = html_string
    #@REGEX_TAGS = /(<\/?[^>]+>)/
    #@REGEX_TEXT = /<\/?[^>]+>|([A-z0-9]+)/
    #@REGEX_CLASS = /(class=['|"].*['|"]+)/
    #@REGEX_ID = /(id=['|"].*['|"])/
    #@REGEX_NAME = /(name=['|"].*['|"])/
    @REGEX_ALL = /(<\/?[^>]+[>])|(<\/?[^>]+['|"].*?['|"]>)|([A-z0-9='\-!\.\s]+)/

    @tags = []
    @text = []
    @html_text = []
  end

#----------

  def parse_html

    @html_text = @html_string.scan(@REGEX_ALL)
    @html_text.flatten!
    @html_text.compact!

    @html_text.map! { |e| e.strip}

  end

#----------

  def grow_html_tree

    @root_node = Tree.new(@html_text[0], [], nil, @html_text[-1])
    current_node = @root_node

    for i in 1...@html_text.length
      if @html_text[i].start_with?("</")
        current_node.closer = @html_text[i]
        current_node = current_node.parent
      else
        new_node = Tree.new(@html_text[i], [], current_node)
        current_node.children << new_node
        current_node = new_node
      end
    end

  end

#----------

 def write_to_file(node)
  current_node = node

  current_node.children.each do |e|
    current_node = e
    puts current_node.type
    puts current_node.closer
    write_to_file(current_node)
  end

 end

#----------

  def dom_builder

    parse_html
    grow_html_tree
    puts @root_node.type
    write_to_file(@root_node)

  end



end

#=begin

parser = DOMParser.new("<html>
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
#=end




parser.dom_builder


=begin
 
#----------

  def parse_tags
    @tags << @html_string.scan(@TAGS)
    @tags.flatten!
  end

#----------

  def parse_text
    @text << @html_string.scan(@TEXT)
    @text.flatten!
  end

#----------

  def grow_tree
    @root_node = Tree.new(@tags[0], [], nil)
    current_node = @root_node

    for i in 1...@tags.length
      if @tags[i].include?("</")
        current_node = current_node.parent
      else
        new_node = Tree.new(@tags[i], [], current_node)
        current_node.children << new_node
        current_node = new_node
      end
    end
  end

#----------

  def rewrite_html
    tag_counter = 0
    @text.each do |e|
      if e.nil?
        puts @tags[tag_counter]
        tag_counter += 1
      else
        print e
      end
    end
  end




=end



#abc