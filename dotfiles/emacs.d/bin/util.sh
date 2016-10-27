# -*- mode: sh -*-
EMACS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
TOP_LEVEL="$(git rev-parse --show-toplevel)"
TARGET="$EMACS_DIR/README.org"
REPOSITORY_NAME="$(realpath --relative-to="$TOP_LEVEL" "$TARGET")"

readme_was_updated() {
	git diff HEAD HEAD~1 --name-only | grep --quiet "$REPOSITORY_NAME"
}

update_index () {
	emacsclient -e "(with-current-buffer (find-file-noselect \"$TARGET\")
  (let ((org-export-headline-levels 10))
    (org-html-export-to-html)))"
	cp -f "$EMACS_DIR/README.html" "$TOP_LEVEL/index.html"
}

commit_index_changes () {
	git add "$TOP_LEVEL/index.html"
	git commit -m "[Emacs] Update github pages index file"
}
