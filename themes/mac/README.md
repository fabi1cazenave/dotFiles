This is a Mac OSX-like gtk key theme:

 - <kbd>alt+[arrows]</kbd> = word movements
 - <kbd>alt+[backspace|delete]</kbd> = delete word
 - <kbd>super+[arrows]</kbd> = paragraph movements
 - <kbd>super+[backspace|delete]</kbd> = delete line

Possibly useful links: [one](http://mail.gnome.org/archives/commits-list/2011-January/msg11124.html), [two](http://pastebin.ch/5314).

This works in GTK apps (including Firefox, Thunderbird…), a Qt equivalent would be appreciated.
Still experimental, use at your own risk.

To enable it, you might have to use `dconf-editor` and change the setting:
org/gnome/desktop/interface/gtk-key-theme

