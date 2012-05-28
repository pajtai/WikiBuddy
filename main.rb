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
  tree.addFootNote

  editor.addSidebar tree.getOutput

  tree = TreeMaker.new all_pages
  tree.setShowDepth(MAX_PARSE_DEPTH)
  tree.setFiller(" . ")
  tree.setBullet("")
  tree.addDepthsToPages all_pages[ROOT], 0, Array.new
  tree.showTree all_pages[ROOT], 0, Array.new

  tree.finishOffTree

  editor.addFullTree tree.getOutput

end
