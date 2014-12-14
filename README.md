### Autostart:
 ## New:
  - Using lightdm to start openbox session
  - lightdm does not use xinitrc; ~/.xprofile instead
 ## Old:
  - .xinitrc and .scripts/xinit/common
  - .config/openbox/autostart (thunar)
  - .xprofile (use this to start non-window based applications, like xflux, etc)

### GPT + DUET + Win8

- Install Win8 on a VM, and then backup the C:\Windows\Boot folder (and use this instead of extracting install.wim)
- Follow this guide: http://www.rodsbooks.com/bios2uefi/
- Install both SYSLINUX and BootDuet to the EFI partition
- To install win, use a usb drive and then:
	- mount the ISO in udf mode (mount iso.iso folder/ -t udf -o loop)
	- copy all files to the USB, in fat32
  - copy the C:\Windows\Boot\EFI\bootmgfw.efi to the USB
- After windows is installed, install grub2 with (see https://wiki.archlinux.org/index.php/GRUB2):
  - mkdir -p /boot/efi
  - mount -t vfat <EFI_PARTITION> /boot/efi
  - mkdir /boot/efi/EFI
  - modprobe dm-mod
	(install efibootmgr and start live linux with duet/efi)
  - grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck --debug
	- To add a Win8 entry, add to /etc/grub.d/40_custom
	menuentry "Win8" {
		insmod part_gpt
		insmod chain
		set root='(hd0, gpt2)' # gpt2 == sda2
		chainloader /EFI/Microsoft/Boot/bootmgfw.efi
	}
	- grub-mkconfig -o /boot/grub/grub.cfg
	- reboot and done

### Virtual Box + linux-pf
- Install linux-pf-headers
- Install virtualbox-host-dkms
- Then execute `# dkms install vboxhost/$(pacman -Q virtualbox|awk {'print $2'}|sed 's/\-.\+//') -k $(uname -rm|sed 's/\ /\//')`

###Openbox Alt-Tab when on multiple screens
To show the alt-tab dialog on the main screen just change the `primaryMonitor`
value from 1 to 0, in rc.xml (indexes start from 0, not 1)
