#!/bin/bash

#
#--------------------------------------------------------------------------------
function fn_main_menu(){
    clear   
    
    echo "[*] TIBERO DBDeployer main menu"
    echo "-----------------------------------------------------------------"
    echo " 1. install"
    echo " 2. config"
    echo " 3. report"
    echo "-----------------------------------------------------------------"
    echo " press other key to quit"
    echo "-----------------------------------------------------------------"
    printf "Choose the Number : "
    
}
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
fn_main_menu

if [ "$mode" == "run" ]
then
    read press_key
elif [ "$mode" == "auto" ]
then
    press_key="1"
fi

case $press_key in
    1)
        # install module
        . $current_path/config/tibero.cfg
        . $current_path/lib/CommonModule/error.sh
        . $current_path/lib/InstallModule/install_type.sh
        ;;
    2)
        # config module
        . $current_path/config/tibero.cfg
        . $current_path/lib/ReferenceModule/error.sh
        2>/dev/null
        ;;
    3)
        # report module
        ;;
    *)
        exit 1
    ;;
esac


#--------------------------------------------------------------------------------

