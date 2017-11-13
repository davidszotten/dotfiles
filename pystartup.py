# Add auto-completion and a stored history file of commands to your Python
# interactive interpreter. Requires Python 2.0+, readline. Autocomplete is
# bound to the Esc key by default (you can change it - see readline docs).
#
# Store the file in ~/.pystartup, and set an environment variable to point
# to it:  "export PYTHONSTARTUP=~/.pystartup" in bash.

import atexit
import os
import readline
import rlcompleter
import sys

if 'libedit' in readline.__doc__:
    readline.parse_and_bind("bind ^I rl_complete")
else:
    readline.parse_and_bind("tab: complete")

historyPath = os.path.expanduser(
    "~/.pyhistory{}".format(sys.version_info.major)
)

def save_history(historyPath=historyPath):
    import readline
    readline.write_history_file(historyPath)

if os.path.exists(historyPath):
    try:
        readline.read_history_file(historyPath)
    except OSError as exc:
        print('Failed to read history file ({}): {}'.format(historyPath, exc))

atexit.register(save_history)
del os, sys, atexit, readline, rlcompleter, save_history, historyPath
