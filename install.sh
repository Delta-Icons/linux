#!/bin/bash

if [ "$DESKTOP_SESSION" = "gnome" ] | [ "$DESKTOP_SESSION" = "xubuntu" ] | [ "$DESKTOP_SESSION" = "budgie-desktop" ] | [ "$DESKTOP_SESSION" = "pantheon" ] ; then
        mkdir -p Delta ~/.icons
        mv Delta ~/.icons/
        gsettings set org.gnome.desktop.interface icon-theme "Delta"
        echo "installed"
        read blegh
        break
elif [ "$DESKTOP_SESSION" = "plasma" ]; then
        mkdir -p Delta ~/.local/share/icons
        mv Delta ~/.local/share/icons/
        x=`locate plasma-changeicons`
        $x Delta
        echo "installed"
        read blegh
        break
elif [ "$DESKTOP_SESSION" = "cinnamon" ]; then
        read -p "Your Desktop Environment doesn't support a completely automatic install, you will have to select and apply the icon pack in your settings yourself, Proceed? y/N " proceed
        if [ "$proceed" = "y" ]; then
                mkdir -p Delta ~/.local/share/icons
                mv Delta ~/.local/share/icons/
        elif [ "$proceed" = "n" ]; then
                break
        fi
else
        echo "Your Desktop Environment isn't recognised or isn't supported, We can try a few things, or you can look online for other resources,"
        read -p "Abort(0), Place in GTK non-root space(1), Place in Qt non-root space(2), Place in common space (requires root)(3)" whatdo
        if [ "$whatdo" = "0" ]; then
                break
        elif [ "$whatdo" = "1" ]; then
                mkdir -p Delta ~/.icons
                mv Delta ~/.icons/                
                echo "You should now try and apply the icon pack"
                read blegh
        elif [ "$whatdo" = "2" ]; then
                mkdir -p Delta ~/.local/share/icons
                mv Delta ~/.local/share/icons/
                echo "You should now try and apply the icon pack"
                read blegh
        elif [ "$whatdo" = "3" ]; then
                sudo mkdir -p Delta /usr/share/icons
                sudo mv Delta /usr/share/icons
                echo "You should now try and apply the icon pack"
                read blegh
        fi
fi
