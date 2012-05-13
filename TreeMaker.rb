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

      page.setMinDepth depth

      unless @count > MAX_NODES or depth > MAX_DEPTH or page.getMinDepth < depth # or ! page.isOrphaned

        page.setOrphaned false

        now_displayed = Array.new displayed
        @count += 1
        pre = ""
        for i in 2..depth
          pre += "    "
        end

        page_name = page.getPageName
        unless now_displayed.include? page_name
          unless depth == 0
            @output += "\n" + pre + "* [[" + page_name + "]]  "
          end
          now_displayed << page_name

          links = page.getPageLinks
          depth += 1
          links.each do |one_link|
            showTree one_link, depth, now_displayed
          end

        end
      end
    end

    def addDepthsToPages page, depth, displayed

      unless @count > 1000 or depth > MAX_DEPTH

        @count += 1

        page.setMinDepth depth

        now_displayed = Array.new displayed
        @count += 1

        page_name = page.getPageName
        unless now_displayed.include? page_name

          now_displayed << page_name

          links = page.getPageLinks
          depth += 1
          links.each do |one_link|
            addDepthsToPages one_link, depth, now_displayed
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
          # have to set depth to 1, or it won't show up
          showTree first_orphan, 1, Array.new
        end
      end

      @output = @output + "\n\n Total of " + @all_pages.size.to_s + " pages.\n Total of " + @orphaned.to_s + " orphans.\n Total of " + @count.to_s + " nodes."
    end

    def getOutput
      @output
    end

  end

end