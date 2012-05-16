module WikiManager

  class Page

    # Markdown link regexes
    OPEN_LINK = /\[\[/
    CLOSE_LINK = /\]\]/

    SIMPLE_LINK = /([^\]|]+)/
    TWO_PART_LINK = /[^|]+\|([^\]]+)/

    LINKS = [SIMPLE_LINK, TWO_PART_LINK]

    @file_name
    @file_extension
    @page_name
    @all_pages
    # File name w/o the extension
    @page_title
    @sibling_pages
    @missing_pages
    @orphaned
    @minimum_depth

    def initialize file_name, all_pages
      @file_name = file_name
      @all_pages = all_pages
      @file_extension = file_name.split(/\./)[-1]
      @missing_pages = Array.new
      @sibling_pages = Array.new
      @orphaned = true
      @minimum_depth = nil
      # A collection of related page names
    end

    def getMinDepth
      @minimum_depth
    end

    def setMinDepth minimum_depth
      if @minimum_depth.nil? or minimum_depth < @minimum_depth
        @minimum_depth = minimum_depth
      end
    end

    def setOrphaned orphaned
      @orphaned = orphaned
    end

    def isOrphaned
      @orphaned
    end

    def getKey
      @file_name.downcase
    end

    def getExtension
      @file_extension
    end

    def setPageName page_name
      if @page_name.nil?
        @page_name = page_name
      end
    end

    def getPageName
      return @page_name.nil? ?  File.basename(@file_name, '.' + @file_extension).gsub(%r{[-]}, ' ') : @page_name
    end

    def getFileName
      @file_name
    end

    # TODO: is this method needed?
    def getTitle
      if @page_title.nil?
        @page_title = @file_name.split(/\./)[0]
      end
      return @page_title
    end

    def addPageLinks
      @sibling_pages = Array.new
      looking_for_siblings = false

      File.open(WIKI_DIR + @file_name, "r+") do |open_file|
        while line = open_file.gets

          LINKS.each do |link_style|
            line.scan(linkRegex OPEN_LINK, link_style, CLOSE_LINK) { |page_name|
              page_name = page_name[0]

              page_name = PageName.new page_name, @file_extension
              addOnePageLink page_name
            }
          end

        end
        open_file.close
      end
    end

    def linkRegex open, link, close
      /#{open}#{link}#{close}/
    end

    def addOnePageLink page_name
      missing_page = @all_pages[page_name.getPageKey]
      unless missing_page.nil?
        # Remember the humanly name we grabbed from the wiki file
        missing_page.setPageName page_name.getHumanlyName
        unless (@missing_pages.size > 0) and (@missing_pages.include? missing_page)
          @sibling_pages << missing_page
        end
      else
        puts "missing file: " + page_name.getHumanlyName + " in " + @file_name
      end
    end

    def addNewPageLink page
      unless @sibling_pages.include? page
        @sibling_pages << page
      end
    end

    def getPageLinks
      @sibling_pages
    end

    def getMissingPages
      @missing_pages
    end

    def showSiblings
      unless @sibling_pages.size == 0
        puts '--- Linked ---'
        @sibling_pages.each do |one_sibling|
          puts "* " + one_sibling.getPageName
        end
      end
    end

    def showMissingLinks
      unless @missing_pages.size == 0
        puts @file_name + ' is missing:'
        @missing_pages.each do |one_page|
          puts "* " + one_page.getFileName
        end
        puts
      end
    end

    def setMissingLink missingPage
      unless @missing_pages.include? missingPage
        @missing_pages << missingPage
      end
    end

    # Have to pass in the other pages to look in for links to self
    def addMissingLinkNames
      @sibling_pages.each do |sibling_page|
        unless sibling_page.linkedTo self
          sibling_page.setMissingLink self
        end
      end
    end

    def linkedTo page
      @sibling_pages.include? page
    end

    def showPage
      puts @page_name
      puts @file_name
      showSiblings
      showMissingLinks
      puts "\n"
    end

  end
end
