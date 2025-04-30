# Disable the startup banner
c.TerminalIPythonApp.display_banner = False

# Minimal tracebacks for cleaner output (use 'context' or 'verbose' if debugging)
c.InteractiveShell.xmode = "minimal"

# Skip confirmation on exit (you can type exit() directly)
c.TerminalInteractiveShell.confirm_exit = False

# Auto-import useful data science/ML libraries
c.InteractiveShellApp.exec_lines = [
    "import numpy as np",
    "import pandas as pd",
    "import matplotlib.pyplot as plt",
    "import scipy as sp",
    "from IPython.display import display, Markdown",
    "%matplotlib inline",  # Inline plots
    "%load_ext autoreload",  # Always reload changed modules
    "%autoreload 2",
]

# Prompt customization (optional but aesthetic)
c.TerminalInteractiveShell.prompts_class = "IPython.terminal.prompts.Prompts"

# Auto-indent and syntax highlighting
c.TerminalInteractiveShell.autoindent = True
c.TerminalInteractiveShell.highlighting_style = "monokai"  # or 'default', 'vim', etc.

# Pretty print (auto pretty-print dicts, lists etc.)
c.InteractiveShell.ast_node_interactivity = "last_expr"

# Enable editor integration (e.g., `edit some_function`)
c.TerminalInteractiveShell.editor = "nvim"

# History and logging settings
c.HistoryAccessor.enabled = False
c.HistoryManager.hist_file = ":memory:"

c.InteractiveShell.history_length = 0
c.InteractiveShell.cache_size = 0

# Disable automatic magic function expansion (use %magic instead of just magic)
c.InteractiveShell.automagic = False
