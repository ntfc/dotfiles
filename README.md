> **NOTE:** some configs are not yet "stow friendly"

These are my dotfiles for ArchLinux with Openbox. I am using [GNU stow][stow] to manage symlinks across the system. stow makes it very easy to have a central repository of dotfiles that can be used in many machines and by different users.

# Managing with stow

> **TODO:** explain how to install with stuff. See the [installation steps][steps] gist.

# Openbox

[LightDM][lightdm] is used to startup a GUI environment. I use to login and to start an [Openbox][openbox] session.

Since I am using LightDM, [`~/.xprofile`][xprofile] is used instead of the usual [`~/.xinitrc`][xinitrc] to start applications/scripts on session startup.

Besides `~/.xprofile`, some applications (mostly GUI) are started by Openbox's `~/.config/openbox/autostart`. In reality, `~/.xprofile` only invokes `~/.scripts/startup`.

> See [startup](startup) and [openbox](openbox).

## Key bindings

| Key Binding | Description |
|-------------|-------------|
| <kbd>Shift</kbd><kbd>Alt</kbd><kbd>C</kbd> | closes the current window, except when the window is a `urxvt` terminal, in which case nothing is done. I like this because it prevents me from accidently closing a `tmux` session with multiple windows/panes.
| <kbd>Shift</kbd><kbd>Alt</kbd><kbd>Return</kbd> | Open or focus on a currenly existing `urxvt` terminal. Since I use `tmux`, I don't need multiple terminal windows
| <kbd>Alt</kbd><kbd>P</kbd> | show a `dmenu_run` prompt to execute applications
| <kbd>Shift</kbd><kbd>Win</kbd><kbd>Up/Down</kbd> | Maximize/Minimize window
| <kbd>Alt</kbd><kbd>1..4</kbd> | Show desktop number `1..4`
| <kbd>Shift</kbd><kbd>Alt</kbd><kbd>1..4</kbd> | Move current window to desktop number `1..4`
| <kbd>Win</kbd><kbd>Arrow</kbd> | Go to desktop
| <kbd>Alt</kbd><kbd>I/M</kbd> | Grow window up/down
| <kbd>Alt</kbd><kbd>H/L</kbd> | Grow window left/right
| <kbd>Shift</kbd><kbd>Alt</kbd><kbd>I/M</kbd> | Shrink window up/down
| <kbd>Shift</kbd><kbd>Alt</kbd><kbd>H/L</kbd> | Shrink window left/right
| <kbd>Shift</kbd><kbd>Alt</kbd><kbd>Arrow</kbd> | Move the window
| <kbd>Ctrl</kbd><kbd>Alt</kbd><kbd>L</kbd> | Lock screen
| <kbd>Shift</kbd><kbd>Alt</kbd><kbd>T</kbd> | Keep current window on top

# terminal

I use [`urxvt`][urxvt] as my terminal emulator, [`zsh`][zsh] is my shell and [`tmux`][tmux] is how I manage multiple shell sessions. 

I like to have only one terminal window open (with as much tmux windows inside), and so I have a script to open a new `urxvt` terminal only if it doesn't already exists, in which case it simply focus on the terminal 

> See [urxvt](urxvt), [zsh](zsh), [tmux](tmux)

# VirtualBox and vagrant

I always have issues when dealing with these two together, so here is what I usually need to install and modprobe to make them work:

```
# pacman -S virtualbox virtualbox-host-modules virtualbox-guest-modules virtualbox-guest-iso virtualbox-guest-utils
# modprobe vboxdrv vboxnetadp vboxnetflt vboxpci vboxnetadp vboxguest
```

After this, you should be good to `vagrant up`. Or not.

# (Some) References

* http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html
* [xero/dotfiles][xero]
* [dharmab/ansible-archlinux][ansiblearch]


[stow]: https://www.gnu.org/software/stow/
[steps]: https://gist.github.com/ntfc/5dd78a7dc6746c95f786
[lightdm]: https://wiki.archlinux.org/index.php/LightDM
[openbox]: https://wiki.archlinux.org/index.php/Openbox
[xinitrc]: https://wiki.archlinux.org/index.php/Xinitrc
[xprofile]: https://wiki.archlinux.org/index.php/Xprofile
[urxvt]: https://wiki.archlinux.org/index.php/Rxvt-unicode
[zsh]: https://wiki.archlinux.org/index.php/zsh
[tmux]: https://wiki.archlinux.org/index.php/tmux
[xero]: https://github.com/xero/dotfiles
[ansiblearch]: https://github.com/dharmab/ansible-archlinux/
