#!/bin/bash
GTK_Apply () {
        mkdir -p Delta ~/.icons
        mv Delta ~/.icons/
}
QT_Apply () {
        mkdir -p Delta ~/.local/share/icons
        mv Delta ~/.local/share/icons/
}
Common_Apply () {
        sudo mkdir -p Delta /usr/share/icons
        sudo mv Delta /usr/share/icons
}
End_Program () {
        read blegh
        break        
}
if [ "$DESKTOP_SESSION" = "gnome" ] | [ "$DESKTOP_SESSION" = "xubuntu" ] | [ "$DESKTOP_SESSION" = "budgie-desktop" ] | [ "$DESKTOP_SESSION" = "pantheon" ] ; then
        GTK_Apply
        gsettings set org.gnome.desktop.interface icon-theme "Delta"
        echo "installed"
        End_Program
elif [ "$DESKTOP_SESSION" = "plasma" ]; then
        QT_Apply
        x=`locate plasma-changeicons`
        $x Delta
        echo "installed"
        End_Program
elif [ "$DESKTOP_SESSION" = "cinnamon" ]; then
        read -p "Your Desktop Environment doesn't support a completely automatic install, you will have to select and apply the icon pack in your settings yourself, Proceed? y/N " proceed
        if [ "$proceed" = "y" ]; then
                QT_Apply
        elif [ "$proceed" = "n" ]; then
                break
        fi
else
        echo "Your Desktop Environment isn't recognised or isn't supported, We can try a few things, or you can look online for other resources,"
        read -p "Abort(0), Place in GTK non-root space(1), Place in Qt non-root space(2), Place in common space (requires root)(3)" whatdo
        if [ "$whatdo" = "0" ]; then
                break
        elif [ "$whatdo" = "1" ]; then
                GTK_Apply                
                echo "You should now try and apply the icon pack"
                End_Program
        elif [ "$whatdo" = "2" ]; then
                QT_Apply
                echo "You should now try and apply the icon pack"
                End_Program
        elif [ "$whatdo" = "3" ]; then
                Common_Apply
                echo "You should now try and apply the icon pack"
                read blegh
        fi
fi
