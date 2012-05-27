module WikiManager
  # TODO - don't do this with file manipulation, ignore and check in link maker instead

  class RemoveRels
    @directory

    def initialize directory
      @directory = directory
    end

    def removeWikiBuddyAddedRels
      previous_empty = false
      temp = nil
      Dir.foreach @directory do |one_file|
        one_file_name = File.basename(one_file)
        next if ! one_file_name.match(VALID_PAGE_RE)
        next if one_file_name.match(META_FILE)

        text = ""
        File.open(WIKI_DIR + one_file, "r") do |open_file|
          first = true

          open_file.each_line do |line|

            break if line.match(RELATED_TO)

            if first
              next if line.match(/^[\s]?$/)
              first = false
            end

            if line.match(/^[\s]?$/)
              temp = temp.nil? ? line : temp + line
              previous_empty = true
            else
              if previous_empty
                line = temp + line
                temp = nil
                previous_empty = false
              end
            end

            if !previous_empty
              text += line
            end

          end
        end

        File.open(WIKI_DIR + one_file, 'w') { |f| f.write(text) }
      end
    end
  end

end
