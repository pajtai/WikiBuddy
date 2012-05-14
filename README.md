WikiBuddy
=========

### About:

This simple Ruby script (`main.rb`) does two things. It makes sure the links under the `### Related to:` heading
are reciprocal, and it automatically creates a tree of your pages for your `_Sidebar`. The relationships in the tree
are based on the `### Related to:` sections. 

WikiBuddy was designed to work with the Wiki on GitHub. So far it only supports markdown pages.

### Installing:

1. Clone your GitHub Wiki repository onto the disk that will house WikiBuddy.
2. Clone this repository and modify `Constants.rb`, so that the `WIKI_DIR` constant points to your GitHub Wiki Git repository.
3. `git pull` from your Wiki to make sure you are up to date.
4. Create a `root.md` page that has a `### Related to:` section pointing to your "top level" pages.
5. Create a `_Sidebar.md` page. You can just put a `.` for its contents, since it will get overwritten.
6. Run `main.rb`. This will modify some files by adding reciprocal "Related to" links, and it will overwrite
`_Sidebar.md` with a page tree.
```bash
./main.rb`
```
6. You should probably make sure you're okay with the changes in you GitHub Wiki repository. For example
```bash
# see what files were changed
git status
# see what the changes were
git diff
# if you don't like the changes for a file / files, revert them
git checkout filename.md
```
7. Update your GitHub Wiki
```bash
git commit -a -m "your wiki update message here"
git push
```
8. Go look at the changes