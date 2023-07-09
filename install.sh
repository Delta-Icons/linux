#!/bin/bash
GTK_Apply () {
        rm -rf ~/.icons/Delta
        mkdir -p Delta ~/.icons
        cp -r Delta ~/.icons/
}
QT_Apply () {
        rm -rf ~/.local/share/icons/Delta
        mkdir -p Delta ~/.local/share/icons
        cp -r Delta ~/.local/share/icons/
}
Common_Apply () {
        rm -rf /usr/share/icons/Delta
        sudo mkdir -p Delta /usr/share/icons
        sudo cp -r Delta /usr/share/icons
}
if [ "$DESKTOP_SESSION" = "gnome" ] | [ "$DESKTOP_SESSION" = "xubuntu" ] | [ "$DESKTOP_SESSION" = "budgie-desktop" ] | [ "$DESKTOP_SESSION" = "pantheon" ] | [ "$DESKTOP_SESSION" = "xfce" ] ; then
        GTK_Apply
        gsettings set org.gnome.desktop.interface icon-theme "Delta"
        echo "installed"
        exit 0
elif [ "$DESKTOP_SESSION" = "plasma" ]; then
        QT_Apply
        x=`locate plasma-changeicons`
        $x Delta
        echo "installed"
        exit 0
elif [ "$DESKTOP_SESSION" = "cinnamon" ]; then
        read -p "Your Desktop Environment doesn't support a completely automatic install, you will have to select and apply the icon pack in your settings yourself, Proceed? y/N " proceed
        if [ "$proceed" = "y" ]; then
                QT_Apply
        elif [ "$proceed" = "n" ]; then
                exit 1
        fi
else
        echo "Your Desktop Environment isn't recognised or isn't supported, We can try a few things, or you can look online for other resources,"
        read -p "Abort(0), Place in GTK non-root space(1), Place in Qt non-root space(2), Place in common space (requires root)(3)" whatdo
        if [ "$whatdo" = "0" ]; then
                exit 1
        elif [ "$whatdo" = "1" ]; then
                GTK_Apply                
                echo "You should now try and apply the icon pack"
                exit 0
        elif [ "$whatdo" = "2" ]; then
                QT_Apply
                echo "You should now try and apply the icon pack"
                exit 0
        elif [ "$whatdo" = "3" ]; then
                Common_Apply
                echo "You should now try and apply the icon pack"
                exit 0
        fi
fi
