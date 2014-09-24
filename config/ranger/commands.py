#| File    : ~/.config/ranger/commands.py
#| Charset : UTF-8
#| Author  : Fabien Cazenave
#| Source  : https://github.com/fabi1cazenave/dotFiles
#|

from ranger.api.commands import *

class zip(Command):
    """:zip <archive>

    Creates a ZIP archive of the selected files
    """

    def execute(self):
        if not self.arg(1):
            self.fm.notify('Syntax: zip <archive>', bad=True)
        else:
            files = ' '.join(f.basename for f in self.fm.thistab.get_selection())
            self.fm.run('zip -r "' + self.arg(1) + '" ' + files)

