module WikiManager
  RELATED_TO = "### Related to:"
  # No trailing slash
  WIKI_DIR = "../Reference.wiki/"
  WHITE_SPACE = '-'
  VALID_PAGE_RE = /^(.+)\.(md|mkdn?|mdown|markdown|textile|rdoc|org|creole|re?st(\.txt)?|asciidoc|pod|(media)?wiki)$/i
  ROOT = 'root.md'
  SIDEBAR = '_Sidebar.md'
  MAX_DEPTH = 3
end