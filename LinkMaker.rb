module WikiManager

  class LinkMaker

    @all_pages

    def initialize all_pages
      @all_pages = all_pages
    end

    # This will link all existing Page objects as they are linked in the files
    # It does not add any links to existing files
    def linkPages
      @all_pages.each do |lower_file, one_page|
        one_page.addPageLinks
      end
      @all_pages.each do |lower_file, one_page|
        one_page.addMissingLinkNames
      end
    end

  end

end