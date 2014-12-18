# handler.sh
Use this handler instead of the default `/etc/acpi/handler.sh`. Handle all acpi related actions in here.
# mpd-control
Called from `handler.sh`, with just one argument. Calls mpc to control mpd accordingly.
# TODO
- Use the `functions` file to execute programs as a certain user, ie. as for `su user -c 'command'`
