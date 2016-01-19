# Openbox Shortcuts
- Shift+Alt+C: closes the current window, except when the window is a urxvt terminal. In that case, it does nothing
- Shift+Alt+Return: opens a new terminal (tmux + urxvt). If there is an already created terminal, just focus on that
- Alt+P: show a dmenu_run prompt
- Shift+Win+Up/Down: Maximize/Minimize window
- Alt+[NUM]: Show desktop NUM
- Shift+Alt+[NUM]: Move current window to desktop NUM
- Win+Left/Right/Up/Down: Show desktop to the left/right/up/down
- Alt+I/M/H/L: Grow window up/down/left/right
- Shift+Alt+I/M/H/L: Shrink window up/down/left/right
- Shift+Alt+Left/Right/Up/Down: Move the window

# Alt+Tab when on multiple screens
- To show the alt+tab dialog on the main screen just change the `primaryMonitor` value from 1 to 0, in rc.xml (indexes start from 0, not 1)
