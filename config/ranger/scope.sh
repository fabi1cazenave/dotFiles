#!/bin/bash
#| File    : ~/.config/ranger/scope.sh
#| Charset : UTF-8
#| Author  : Fabien Cazenave
#| Source  : https://github.com/fabi1cazenave/dotFiles
#|

# ranger supports enhanced previews.  If the option "use_preview_script" is set
# to True and this file exists, this script will be called and its output is
# displayed in ranger.  ANSI color codes are supported.

# NOTES: This script is considered a configuration file.  If you upgrade ranger,
# it will be left untouched. (You must update it yourself.) Also, ranger
# disables STDIN here, so interactive scripts won't work properly.

# Meanings of exit codes:
# code | meaning    | action of ranger
# -----+------------+-------------------------------------------
# 0    | success    | Success. Display stdout as preview.
# 1    | no preview | Failure. Display no preview at all.
# 2    | plain text | Display the plain content of the file.
# 3    | fix width  | Success. Don't reload when width changes.
# 4    | fix height | Success. Don't reload when height changes.
# 5    | fix both   | Success. Don't ever reload.

# Meaningful aliases for arguments:
path="$1"    # Full path of the selected file
width="$2"   # Width of the preview pane (number of fitting characters)
height="$3"  # Height of the preview pane (number of fitting characters)

maxln=200    # Stop after $maxln lines.  Can be used like ls | head -n $maxln

# Find out something about the file:
#mimetype=$(mimetype -b "$path")
mimetype=$(file --mime-type -Lb "$path")
extension=${path##*.}

# Functions:
# "have $1" succeeds if $1 is an existing command/installed program
function have { type -P "$1" > /dev/null; }
# "success" returns the exit code of the first program in the last pipe chain
function success { test ${PIPESTATUS[0]} = 0; }

case "$extension" in
  # Archive extensions: (a bit slow... not sure I like it)
  7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
  rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)
    als "$path" | head -n $maxln
    success && exit 0 || acat "$path" | head -n $maxln && exit 3
    exit 1;;
  # PDF documents:
  pdf)
    #pdftotext -l 10 -nopgbrk -q "$path" - | head -n $maxln | fmt -s -w $width
    success && exit 0;;
  # BitTorrent files:
  torrent)
    transmission-show "$path" | head -n $maxln && exit 3
    success && exit 5;;
  # HTML pages:
  htm|html|xhtml)
    have w3m    && w3m    -dump "$path" | head -n $maxln | fmt -s -w $width && exit 4
    have lynx   && lynx   -dump "$path" | head -n $maxln | fmt -s -w $width && exit 4
    have elinks && elinks -dump "$path" | head -n $maxln | fmt -s -w $width && exit 4
    ;; # fall back to highlight/cat if theres no lynx/elinks
esac

case "$mimetype" in
  # Syntax highlight for text files:
  text/* | */xml)
    highlight --out-format=ansi "$path" | head -n $maxln
    success && exit 5 || exit 2;;
  # Display information about images and media files:
  image/* | video/* | audio/*)
    have mediainfo && mediainfo "$path" | sed 's/ \{16\}:/:/;' && exit 5
    have exiftool  && exiftool  "$path"                        && exit 5
    ;; # fall back to file info
esac

# Display general information for other files:
file -Lb "$path" | sed 's/,\s*/\n/g' && exit 5
exit 1

