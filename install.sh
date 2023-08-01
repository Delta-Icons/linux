#!/bin/bash

RESET="\x1b[0m"
CORAL_PINK="\x1b[38;2;255;131;125m"
FUZZY_WUZZY="\x1b[38;2;186;101;97m"
PALE_GOLD="\x1b[38;2;248;193;140m"
JASMINE="\x1b[38;2;249;222;129m"
GRANNY_S_A="\x1b[38;2;152;220;154m"
PALE_R_E_B="\x1b[38;2;150;223;211m"
BABY_BLUE_E="\x1b[38;2;154;190;255m"
DARK_PASTEL_BLUE="\x1b[38;2;114;141;190m"
UBE="\x1b[38;2;140;114;189m"

case $DESKTOP_SESSION in
gnome | xubuntu | budgie-desktop | pantheon | xfce)
        Installation_Method=GTK
        Installation_Path=~/.icons
        ;;
plasma | plasmawayland | cinnamon)
        Installation_Method=QT
        Installation_Path=~/.local/share/icons
        ;;
esac

function Delta_Apply () {
        echo -e "\nRunning $DARK_PASTEL_BLUE$Installation_Method$RESET\n"
        curl -L -O https://github.com/Delta-Icons/linux/releases/latest/download/delta-linux.zip
        case $Installation_Method in
        Generic)
                sudo rm -rf "$Installation_Path"/Delta
                unzip -d delta-linux delta-linux.zip > /dev/null
                sudo mv delta-linux/ "$Installation_Path"
                ;;
        *)
                rm -rf "$Installation_Path"/Delta
                unzip  delta-linux.zip -d "$Installation_Path" > /dev/null
                ;;
        esac
        echo -en "\n${UBE}Finished!$RESET "
}

echo -e "Welcome to the$CORAL_PINK Delta$RESET installation script!\n"
case $Installation_Method in
GTK)
        case $Installation_Method in
        GTK)
                echo -e "The current desktop ($PALE_GOLD${DESKTOP_SESSION^}$RESET) supports automatic installation.\n"
                ;;
        QT)

                echo -e "The current desktop ($RESET$DESKTOP_SESSION$RESET) supports Manual installation.
You will have to manually select the pack from your settings panel.\n"
                ;;
        esac
        echo -e "Do you wish to continue?$PALE_R_E_B Y${RESET}/n"
        read -r -p "-> " proceed
        case $proceed in
        [Yy]* | "")
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
                        echo "Delta has been moved, You can now apply Delta from your settings panel."
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
        echo -e "Your Desktop Environment ($PALE_GOLD${DESKTOP_SESSION^}$RESET) isn't recognised or isn't supported yet.
Please open an issue on the Linux branch, you can also try and install
by looking up how your Desktop Environment handles Icon Packs. \n"

        echo -e "${JASMINE}0 -$RESET Abort 
${GRANNY_S_A}1 -$RESET Place in the GTK path (~/.icons)
${PALE_R_E_B}2 -$RESET Place in the QT path (~/.local/share/icons)
${BABY_BLUE_E}3 -$RESET Place in the$FUZZY_WUZZY ROOT$RESET path (/usr/share/icons)"

        read -rp "-> "  whatdo
        case $whatdo in
        0)
                exit 0
                ;;
        1)
                Installation_Method=GTK
                Installation_Path=~/.icons
                Delta_Apply
                echo "You should now try and apply the icon pack."
                ;;
        2)
                Installation_Method=QT
                Installation_Path=~/.local/share/icons
                Delta_Apply
                echo "You should now try and apply the icon pack."
                ;;
        3)
                Installation_Method=Generic
                Installation_Path=/usr/share/icons
                Delta_Apply
                echo "You should now try and apply the icon pack."
                ;;
        *)
                echo "Invalid Input"
        esac
esac
