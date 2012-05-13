module WikiManager

  class PageName

    @humanly_name
    @file_extension
    @formatted_name


    def initialize unformatted_name, extension
      @humanly_name = unformatted_name
      @file_extension = extension
    end

    # returns a name that looks like a file name except for capitalization
    def getPageKey
      if @formatted_name.nil?
            @formatted_name = @humanly_name.split(/\./)[0].gsub(%r{\s},WHITE_SPACE).gsub(%r{[/<>+]}, WHITE_SPACE).downcase + '.' + @file_extension
      end
      return @formatted_name
    end

    def getHumanlyName
      @humanly_name
    end

  end

end
