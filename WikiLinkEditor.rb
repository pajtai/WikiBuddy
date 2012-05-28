  module WikiManager

  class WikiLinkEditor

    @all_pages

    def initialize all_pages
      @all_pages = all_pages
    end

    def addMissingLinks
      @all_pages.each_value do |one_page|
        missing_pages = one_page.getMissingPages
        unless missing_pages.size == 0
          missing_pages.each do |missing_page|
            puts one_page.getFileName + " is missing: " + missing_page.getFileName

            File.open(WIKI_DIR + one_page.getFileName, "r+") do |open_file|

              if hasRelationships open_file
                puts "adding to: " + one_page.getFileName
                open_file << "  \n[[" + missing_page.getPageName + "]]"
              else
                puts "first mod of: " + one_page.getFileName
                open_file << "\n\n" + RELATED_TO
                open_file << "  \n[[" + missing_page.getPageName + "]]"
              end

              open_file.close
            end

            # now add it to the object tree too
            one_page.addNewPageLink missing_page

          end
        end
      end
    end

    # Describes whether the the openFile has a list of
    #   related files in it, and whether in those related files
    #   sibling is referred to.
    def hasRelationships open_file
      relationships = false
      while line = open_file.gets
        if line.match(RELATED_TO)
          relationships = true
        end
      end
      relationships
    end

    def addSidebar output
      File.open(WIKI_DIR + SIDEBAR, "w") do |open_file|
        open_file << output
      end
    end

    def addFullTree output
      File.open(WIKI_DIR + FULL_TREE, "w") do |open_file|
        open_file << "<pre>" + output + "</pre>"
      end
    end

  end

end