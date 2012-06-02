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
      @max_show_depth = MAX_SHOW_DEPTH
      @filler = "    "
      @bullet = "*"
    end

    def setShowDepth(showDepth)
      @max_show_depth = showDepth
    end

    def setFiller(filler)
      @filler = filler
    end

    def setBullet(bullet)
      @bullet = bullet
    end

    def showTree(page, depth, displayed)

      page.setMinDepth depth

      unless depth > @max_show_depth # or page.getMinDepth < depth # or ! page.isOrphaned

        page.setOrphaned false

        now_displayed = Array.new displayed

        pre = ""
        for i in 2..depth
          pre += @filler
        end

        page_name = page.getPageName
        unless now_displayed.include? page_name
          unless depth == 0
            @count = @count + 1
            @output += "\n" + pre + @bullet + " [[" + page_name + "]]  "
          end
          now_displayed << page_name

          links = page.getPageLinks
          depth += 1
          links.each do |one_link|
            # only show links down the tree, not up
            unless page.getMissingPages.include? one_link
              showTree one_link, depth, now_displayed
            end
          end

        end
      end
    end

    def addDepthsToPages page, depth, displayed

      unless depth > MAX_PARSE_DEPTH

        page.setMinDepth depth

        now_displayed = Array.new displayed

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

      @output += "  \n\n---------- Pages Not in Main Tree ----------  \n"

      while checkForOrphans > 0 do
        first_orphan = firstOrphan
        unless first_orphan.nil?
          # have to set depth to 1, or it won't show up
          showTree first_orphan, 1, Array.new
        end
      end
    end

    def addFootNote
      @orphaned = checkForOrphans

      @output = "#{@output} \n\n Total of #{@all_pages.size.to_s} pages.  \n" +
          " Total of #{@orphaned.to_s} pages not in main tree.  \n Total of #{@count.to_s} nodes.  \n" +
          " This Sidebar and the \"Linked From\" sections created by <a href=\"#{WIKI_BUDDY}\">Wiki Buddy</a>  \n" +
          " The full tree is at [[" + File.basename(FULL_TREE, ".md") + "]]  \n"
    end

    def getOutput
      @output
    end

  end

end