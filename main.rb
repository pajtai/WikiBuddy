#!/usr/bin/env ruby
module WikiManager
  CURRENT_DIR = File.dirname(__FILE__)

  require CURRENT_DIR + '/Constants'
  require CURRENT_DIR + '/RemoveRels'
  require CURRENT_DIR + '/PageName'
  require CURRENT_DIR + '/Page'
  require CURRENT_DIR + '/PageMaker'
  require CURRENT_DIR + '/LinkMaker'
  require CURRENT_DIR + '/WikiLinkEditor'
  require CURRENT_DIR + '/TreeMaker'

  require CURRENT_DIR + '/Show'

  # TODO:
  # 1 - Create all Page objects
  # 2 - Link all Page objects
  # 3 - Look for missing links & add them to Page objects
  # 4 - Add missing links to files
  # 5 - Construct tree based on Page objects starting at Root.md
  # 6 - Only show each Page once within each single branch of tree
  # 7 - Keep track of Pages that were shown
  # 8 - Show orphan Pages. Start at 1st one and show all links

  remove_rels = RemoveRels.new WIKI_DIR
  remove_rels.removeWikiBuddyAddedRels

  page_maker = PageMaker.new WIKI_DIR
  all_pages = page_maker.getAllPages

  link_maker = LinkMaker.new all_pages
  link_maker.linkPages

  editor = WikiLinkEditor.new all_pages
  editor.addMissingLinks

  tree = TreeMaker.new all_pages
  tree.addDepthsToPages all_pages[ROOT], 0, Array.new
  tree.showTree all_pages[ROOT], 0, Array.new
  tree.finishOffTree

  editor.addSidebar tree.getOutput

  tree = TreeMaker.new all_pages
  tree.setShowDepth(100)
  tree.setFiller(" . ")
  tree.setBullet("")
  tree.addDepthsToPages all_pages[ROOT], 0, Array.new
  tree.showTree all_pages[ROOT], 0, Array.new

  editor.addFullTree tree.getOutput

end
