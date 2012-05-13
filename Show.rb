module WikiManager

  class Show

    @all_pages

    def initialize all_pages
      @all_pages = all_pages
    end

    def showAllPages
      @all_pages.each_value do |one_page|
        one_page.showPage
      end
    end

  end
end