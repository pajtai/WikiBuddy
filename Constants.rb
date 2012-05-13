module WikiManager
  RELATED_TO = "### Related to:"
  TO_WIKI = File.dirname(__FILE__) + "/.."
  WHITE_SPACE = '-'
  WIKI_DIR = TO_WIKI + "/"
  VALID_PAGE_RE = /^(.+)\.(md|mkdn?|mdown|markdown|textile|rdoc|org|creole|re?st(\.txt)?|asciidoc|pod|(media)?wiki)$/i
  ROOT = 'root.md'
  SIDEBAR = '_Sidebar.md'
  MAX_DEPTH = 3
end