#!/bin/bash
GTK_Apply () {
        echo "Running GTK installation"
        rm -rf ~/.icons/Delta
        mkdir -p Delta ~/.icons
        cp -r Delta ~/.icons/
        echo "Installed"
}
QT_Apply () {
        echo "Running QT installation"
        rm -rf ~/.local/share/icons/Delta
        mkdir -p Delta ~/.local/share/icons
        cp -r Delta ~/.local/share/icons/
        echo "Installed"
}
Common_Apply () {
        echo "Running generic installation on /usr/share/icons/"
        rm -rf /usr/share/icons/Delta
        sudo mkdir -p Delta /usr/share/icons
        sudo cp -r Delta /usr/share/icons
        echo "Installed"
}

curl -L -O https://github.com/Delta-Icons/linux/releases/latest/download/delta-linux.zip
unzip delta-linux.zip -d delta-linux > /dev/null
  cd delta-linux || exit
    echo "Current desktop: $DESKTOP_SESSION"
    case $DESKTOP_SESSION in
      gnome | xubuntu | budgie-desktop | pantheon | xfce)
              GTK_Apply
              gsettings set org.gnome.desktop.interface icon-theme "Delta"
              exit 0
              ;;
      plasma)
              QT_Apply
              x=$(locate plasma-changeicons)
              $x Delta
              exit 0
              ;;
      cinnamon)
              read -pr "Your Desktop Environment doesn't support a completely \
              automatic install, you will have to select and apply the icon \
              pack in your settings yourself, Proceed? y/N " proceed
              case $proceed in
              y)
                      QT_Apply
                      exit 0
                      ;;
              n)
                      exit 1
                      ;;
              esac
              ;;
      *)
              echo "Your Desktop Environment isn't recognised or isn't \
              supported, Please open an issue on the Linux branch,\
              you can also try and installing by looking up where your Desktop\
              Envirnoment supports Icon Packs"
              read -pr "Abort(0), Place in GTK non-root space(1), \
              Place in Qt non-root space(2), Place in common space \
              (requires root)(3)" whatdo
              case $whatdo in
              0)
                      exit 1
                      ;;
              1)
                      GTK_Apply                
                      echo "You should now try and apply the icon pack"
                      exit
                      ;;
              2)
                      QT_Apply
                      echo "You should now try and apply the icon pack"
                      exit 0
                      ;;
              3)
                      Common_Apply
                      echo "You should now try and apply the icon pack"
                      exit 0
                      ;;
              *)
                      echo "Invalid Input"
              esac
    esac
  cd ..
rm delta-linux.zip
rm -rf delta-linux
