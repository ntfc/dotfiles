# Power management scripts
- autohibernate: Hibernates computer when power is under 3%. It uses systemctl hibernate
- powernow: Shows the current power usage, when on battery 
- powerdown: Puts computer in powersave mod. Must be run as root user
- powerdown-functions: Helper functions to powerdown and powerup
- powerup: Puts computer in performance/ondemand mod. Must be run as root user

Power actions are handled by acpi, NOT by systemd. To do so, it's necessary to disable all power handlers in `/etc/systemd/logind.conf` and then `restart logind.service`.

See `~/.scripts/acpi/` for handle acpi power events.

