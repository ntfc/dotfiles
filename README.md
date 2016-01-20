My configs on Arch Linux + Openbox + zsh + rxvt-unicode (Dell version)

# Autostart:
- Using lightdm to start an openbox session
- lightdm does not use `~/.xinitrc`; use `~/.xprofile`
  * `.xprofile` executes `~/.scripts/start-up` for start-up applications
  
### Old way:
- .xinitrc and .scripts/xinit/common
- .config/openbox/autostart (thunar)
- .xprofile (use this to start non-window based applications, like xflux, etc)

# openbox

- <kbd>S-A-C</kbd>: closes the current window, except when the window is a urxvt terminal. In that case, it does nothing
- Shift+Alt+Return: opens a new terminal (tmux + urxvt). If there is an already created terminal, just focus on that
- Alt+P: show a dmenu_run prompt
- Shift+Win+Up/Down: Maximize/Minimize window
- Alt+[NUM]: Show desktop NUM
- Shift+Alt+[NUM]: Move current window to desktop NUM
- Win+Left/Right/Up/Down: Show desktop to the left/right/up/down
- Alt+I/M/H/L: Grow window up/down/left/right
- Shift+Alt+I/M/H/L: Shrink window up/down/left/right
- Shift+Alt+Left/Right/Up/Down: Move the window

# zsh + rxvt-unicode + tmux
- *Do not set $TERM in `.zshrc`!*
- Set $TERM in:
  * urxvt: set `URxvt*termName: rxvt-unicode-256color` in `~/.Xresources`
  * tmux: add `set -g default-terminal "rxvt-unicode-256color"` to `~/.tmux.conf`

# Virtual Box + linux-pf
- Install linux-pf-headers
- Install virtualbox-host-dkms
- Then execute `# dkms install vboxhost/$(pacman -Q virtualbox|awk {'print $2'}|sed 's/\-.\+//') -k $(uname -rm|sed 's/\ /\//')`

# EFI / UEFI
- `/boot/EFI`: EFI partition (ef00)
- `/boot`: ext2 partition
- Syslinux cannot be used because EFI partition and `/boot` are in different directories
