module WikiManager
  RELATED_TO = "### Related to:"
  # No trailing slash
  WIKI_DIR = "../Reference.wiki/"
  WHITE_SPACE = '-'
  VALID_PAGE_RE = /^(.+)\.(md|mkdn?|mdown|markdown|textile|rdoc|org|creole|re?st(\.txt)?|asciidoc|pod|(media)?wiki)$/i
  META_FILE = /^_/
  ROOT = 'home.md'
  SIDEBAR = '_Sidebar.md'
  MAX_SHOW_DEPTH = 3
  MAX_PARSE_DEPTH = 10
  MAX_NODES = 5000
  WIKI_BUDDY = 'https://github.com/pajtai/WikiBuddy'
  # very simple url check, not complete
  URL_LINK = /^http[s]?:\/\//
end