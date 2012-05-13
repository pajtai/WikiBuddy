module WikiManager

  class TreeMaker

    @all_pages
    @count
    @output
    @orphaned

    def initialize all_pages
      @all_pages = all_pages
      @count = 0
      @output = ''
      @orphaned = 0
    end

    def showTree page, depth, displayed
      page.setOrphaned false

      now_displayed = Array.new displayed
      @count += 1
      unless @count > 1000 or depth > MAX_DEPTH
        pre = ""
        for i in 1..(4 *depth)
          pre += " "
        end

        page_name = page.getPageName
        unless now_displayed.include? page_name
          @output += "\n" + pre + "* [[" + page_name + "]]"
          now_displayed << page_name

          links = page.getPageLinks
          depth += 1
          links.each do |one_link|
            showTree one_link, depth, now_displayed
        end

        end
      end
    end

    def checkForOrphans
      number_orphans = 0
      @all_pages.each_value do |one_page|
        if one_page.isOrphaned
          number_orphans += 1
        end
      end
      number_orphans
    end

    def firstOrphan
      page = nil
      @all_pages.each_value do |one_page|
        if one_page.isOrphaned
          page = one_page
          break
        end
      end
      return page
    end

    def finishOffTree
      @orphaned = checkForOrphans

      @output += "  \n\n### Orphan Pages:  \n"

      while checkForOrphans > 0 do
        first_orphan = firstOrphan
        unless first_orphan.nil?
          showTree first_orphan, 0, Array.new
        end
      end

      @output = @output + "\n\n Total of " + @all_pages.size.to_s + " pages.\n Total of " + @orphaned.to_s + " orphans."
    end

    def getOutput
      @output
    end

  end

end