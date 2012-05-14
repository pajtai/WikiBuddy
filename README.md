WikiBuddy
=========

### About:

This simple Ruby script (`main.rb`) does two things. It makes sure the links under the `### Related to:` heading
are reciprocal, and it automatically creates a tree of your pages for your `_Sidebar`. The relationships in the tree
are based on the `### Related to:` sections. 

WikiBuddy was designed to work with the Wiki on GitHub. So far it only supports **markdown** pages.

### Example:

[My Reference Wiki](https://github.com/pajtai/Reference/wiki/) uses WikiBuddy for the Sidebar and to make sure all 
"Related To" links are reciprocated between pages.

### Installing:

Basically, clone your wiki, clone this, and point this to your wiki.

* Clone your GitHub Wiki repository onto the disk that will house WikiBuddy.
* Clone this repository and modify `Constants.rb`, so that the `WIKI_DIR` constant points to your GitHub Wiki Git repository.

### Usage

Basically, pull from your wiki, run `main.rb`, and push the changes back to your wiki.

* `git pull` from your Wiki to make sure you are up to date.
* Add relationships to your "top level" pages at the end of `Home.md`. This makes sure that the tree is rooted in the right spot. 

```html
### Related to:
[[HTML]]
[[CSS]]
[[Javascript]]
```
* Create a `_Sidebar.md` page. You can just put a `.` for its contents, since it will get overwritten.
* Run `main.rb`. This will modify some files by adding reciprocal "Related to" links, and it will overwrite
`_Sidebar.md` with a page tree.

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
git commit -a -m "your wiki update message here"
git push
```
* Go look at the changes on GitHub.

### Usage

Add "Related To" links at the end of your files. If you add a relationship to page `B` from page `A`, then Wiki Buddy
will automatically create a link back to page `A` from page `B`.

Here is an example:

```html
### Related to:
[[A Page]]
[[B Page]]
```

### FAQ

* I get a `permission denied` error when I try to run `./main.rb`
    * Change the file permissions for `main.rb` to executable for you, something like:

```bash
chmod 764 main.rb
```