try:
    from pdb import DefaultConfig, Color
except ImporError:
    pass
else:
    class Config(DefaultConfig):
        sticky_by_default = True
        line_number_color = Color.darkgray
        current_line_color = 40
