#!/bin/bash
case $DESKTOP_SESSION in
gnome | xubuntu | budgie-desktop | pantheon | xfce)
        Installation_Method="GTK"
        Installation_Path=~/.icons
        ;;
plasma | plasmawayland | cinnamon)
        Installation_Method="QT"
        Installation_Path=~/.local/share/icons
        ;;
esac

function Delta_Apply () {
        echo "Running $Installation_Method installation"
        rm -rf "$Installation_Path"/Delta
        mkdir -p Delta "$Installation_Path"
        curl -L -O https://github.com/Delta-Icons/linux/releases/latest/download/delta-linux.zip
        case $Installation_Method in
        Generic)
                unzip -d delta-linux delta-linux.zip > /dev/null
                sudo mv delta-linux/ "$Installation_Path"
                ;;
        *)
                unzip  delta-linux.zip -d "$Installation_Path" > /dev/null
                ;;
        esac
        echo "Installed"
}

echo "Current desktop: $DESKTOP_SESSION"
case $Installation_Method in
GTK)
        case $Installation_Method in
        GTK)
                echo "$DESKTOP_SESSION supports fully automated install"
                ;;
        QT)
                echo "$DESKTOP_SESSION doesn't support fully automated installs \
                You will have to manually select it from your settings panel"
                ;;
        esac
        read -r -p "Do You wish to continue? y/n " proceed
        case $proceed in
        y)
                case $Installation_Method in
                GTK)
                        Delta_Apply
                        case $DESKTOP_SESSION in
                        xfce)
                                xfconf-query -c xsettings -p /Net/IconThemeName -s "Delta"
                                ;;
                        *)
                                gsettings set org.gnome.desktop.interface icon-theme "Delta"
                                ;;
                        esac
                        ;;
                QT)
                        Delta_Apply
                        echo "Delta has been moved, You can now apply Delta \
                        from your settings panel"
                        echo "Coming soon to your local customisation store!"
                        ;;
                esac
                        rm -rf delta-linux.zip
                        rm -rf delta-linux
                        ;;
        n)
                exit 0
                ;;
        *)
                echo "invalid input"
                ;;
        esac
        ;;
*)
        echo "Your Desktop Environment isn't recognised or isn't \
        supported yet, Please open an issue on the Linux branch, \
        you can also try and installing by looking up where your Desktop\
        Envirnoment supports Icon Packs"
        read -r -p "Abort(0), Place in GTK non-root space(1), \
        Place in Qt non-root space(2), Place in common space \
        (requires root)(3)" whatdo
        case $whatdo in
        0)
                exit 0
                ;;
        1)
                Installation_Method="GTK"
                Installation_Path=~/.icons
                Delta_Apply
                echo "You should now try and apply the icon pack"
                ;;
        2)
                Installation_Method="QT"
                Installation_Path=~/.local/share/icons
                Delta_Apply
                echo "You should now try and apply the icon pack"
                ;;
        3)
                Installation_Method="Generic"
                Installation_Path=/usr/share/icons
                Delta_Apply
                echo "You should now try and apply the icon pack"
                ;;
        *)
                echo "Invalid Input"
        esac
esac
