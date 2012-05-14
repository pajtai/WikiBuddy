WikiBuddy
=========

### About:

This simple Ruby script (`main.rb`) does two things. It makes sure the links under the `### Related to:` heading
are reciprocal, and it automatically creates a tree of your pages for your `_Sidebar`. The relationships in the tree
are based on the `### Related to:` sections. 

WikiBuddy was designed to work with the Wiki on GitHub. So far it only supports **markdown** pages.

### Installing:

Basically, clone your wiki, clone this, point this to your wiki, pull from your wiki, run `main.rb`, 
and push the changes back to your wiki.

* Clone your GitHub Wiki repository onto the disk that will house WikiBuddy.
* Clone this repository and modify `Constants.rb`, so that the `WIKI_DIR` constant points to your GitHub Wiki Git repository.
* `git pull` from your Wiki to make sure you are up to date.
* Create a `root.md` page that has a `### Related to:` section pointing to your "top level" pages.
* Create a `_Sidebar.md` page. You can just put a `.` for its contents, since it will get overwritten.
* Run `main.rb`. This will modify some files by adding reciprocal "Related to" links, and it will overwrite
`_Sidebar.md` with a page tree.

```bash
./main.rb`
```
* You should probably make sure you're okay with the changes in you GitHub Wiki repository. For example  

```bash
# see what files were changed
git status
# see what the changes were
git diff
# if you don't like the changes for a file / files, revert them
git checkout filename.md
```
* Update your GitHub Wiki

```bash
git commit -a -m "your wiki update message here"
git push
```
* Go look at the changes on GitHub.