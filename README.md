WikiBuddy
=========

### About:

The goal of this Ruby script (`main.rb`) is to go through your wiki pages and make sure that any wiki page you link
to has a reciprocal link back. Also, it automatically creates a tree of your pages for your `_Sidebar`. 
The relationships in the tree are based on all the internal links of your pages. The tree roots itself at your
`Home.rb` page.

WikiBuddy was designed to work with the Wiki on GitHub. So far it only supports **markdown** pages.

### Example:

[My Reference Wiki](https://github.com/pajtai/Reference/wiki/) uses WikiBuddy.

### Installing:

Basically, clone your wiki, clone this, and point this to your wiki.

* Clone your GitHub Wiki repository onto the disk that will house WikiBuddy.
* Clone this repository and modify `Constants.rb`, so that the `WIKI_DIR` constant points to your GitHub Wiki Git 
repository.

### Usage

Basically, pull from your wiki, run `main.rb`, and push the changes back to your wiki.

* `git pull` from your Wiki to make sure you are up to date.
* Add relationships to your "top level" pages in `Home.md`. This makes sure that the tree is rooted 
in the right spot. 
* Run `main.rb`. This will modify some files by adding reciprocal "Related to" links, and it will overwrite
`_Sidebar.md` with a page tree. If `_Sidebar.md` doesn't exist, it will be created.

```bash
./main.rb
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
# if _Sidebar.md (or any other file) was created, add it in to Git
git add -A
# following two lines are what you will usually do to update your GitHub wiki
git commit -a -m "your wiki update message here"
git push
```
* Go look at the changes on GitHub.

If you have a link to page `B` from page `A`, then Wiki Buddy
will automatically create a link back to page `A` from page `B`. It will put the created link in a "Related To"
section. As you create your pages, you do not have to make your own "Related To" sections, since WikiBuddy will
scan the entire page for internal links.

### FAQ

* I get a `permission denied` error when I try to run `./main.rb`
    * Change the file permissions for `main.rb` to executable for you, something like:

```bash
chmod 764 main.rb
```