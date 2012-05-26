module WikiManager

  # Creates a Page object out of each file
  # Page objects in their final form are linked to all their related page objects
  class PageMaker

    @all_pages
    @directory

    def initialize directory
      @all_pages = Hash.new
      @directory = directory
    end

    def getAllPages

      Dir.foreach @directory do |one_file|
        one_file_name = File.basename(one_file)
        next if ! one_file_name.match(VALID_PAGE_RE)
        next if one_file_name.match(META_FILE)
        one_page = Page.new one_file_name, @all_pages
        # Lower case file name as key, to make it easily recoverable if capitalization unknown
        @all_pages[one_page.getKey] = one_page
      end

      @all_pages
    end

  end
end