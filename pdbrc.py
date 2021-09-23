import os.path


try:
    from pdb import DefaultConfig, Color
except ImporError:
    pass
else:
    class Config(DefaultConfig):
        sticky_by_default = True
        line_number_color = Color.darkgray
        current_line_color = 40

        def setup(self, pdb):
            import readline

            histfile = os.path.expanduser("~/.pdb-history")
            try:
                readline.read_history_file(histfile)
            except IOError:
                pass
            import atexit

            atexit.register(readline.write_history_file, histfile)
            readline.set_history_length(500)
