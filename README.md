<p align="center">
	<img src="https://raw.githubusercontent.com/Delta-Icons/Linux/master/delta-logo.png" alt="">
</p>

<h1 align="center" padding="100">Delta Icons</h1>
<p align="center">Matted out icon pack for Linux.</p>

<p align="center">
	<img src="https://raw.githubusercontent.com/Delta-Icons/Linux/master/delta-showcase.png" alt="">
</p>

> Notice, It is recommended to use dark themes with this icon pack.

## Installation Methods

* **Recommended way**:
	- `bash -c "$(curl -sSf https://raw.githubusercontent.com/Delta-Icons/linux/master/install.sh)"`

* **Manual method**:
  	1. Clone this repository to somewhere on your machine: `git clone https://github.com/Delta-Icons/linux.git`
  	2. Move the `Delta` folder to `/usr/share/icons` (All Users), `~/.local/share/icons` (KDE), or `~/.icons` (GTK).
	3. Set the icon theme in one of the following ways:
		- Set the icon theme to `Delta` in the Settings menu for your distro (e.g. KDE System Settings).
		- **GNOME**: Run `gsettings set org.gnome.desktop.interface icon-theme "Delta"`.
        - **XFCE**: Run `xfconf-query -c xsettings -p /Net/IconThemeName -s "Delta"`.

## Our Discord Server
If you need help contributing or just want to chat with other contributors feel free to join us here: https://discord.gg/F9RFqHN <br>
_This server is __not__ intended for requests!_

## Contributing
Please refer to [CONTRIBUTING.md](https://github.com/Delta-Icons/Linux/blob/master/CONTRIBUTING.md)

## Requesting missing icons
* If you wish to request a missing icon to be added, please open a Github issue for this. This icon pack is still in development so any help in identifying future improvements is appreciated.
* Be sure to include the name of the icon(s) found in the .desktop file, found under the `Icon=` line. It is recommended for an image of the icon (or icons) be included in the issue as well.

Licensed under [Creative Commons Attribution-NonCommercial-NoDerivatives License 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)
