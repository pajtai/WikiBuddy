module WikiManager
  # TODO - don't do this with file manipulation, ignore and check in link maker instead

  class RemoveRels
    @directory

    def initialize directory
      @directory = directory
    end

    def removeWikiBuddyAddedRels
      Dir.foreach @directory do |one_file|
        one_file_name = File.basename(one_file)
        next if ! one_file_name.match(VALID_PAGE_RE)
        next if one_file_name.match(META_FILE)

        text = ""
        File.open(WIKI_DIR + one_file, "r") do |open_file|
          after_rels = false
          open_file.each_line do |line|
            if line.match(RELATED_TO)
              after_rels = true
            end
            break if after_rels
            text += line
          end
        end

        File.open(WIKI_DIR + one_file, 'w') { |f| f.write(text) }
      end
    end
  end

end
