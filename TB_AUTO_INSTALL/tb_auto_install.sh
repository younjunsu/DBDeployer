#!/bin/sh
clear

function FN_PRINT_PRESS(){
    echo "Press Enter Key to continue..."
}
function FN_PRINT_TYPE(){
    echo "# 1. SINGLE"
    echo "# 2. TSC"
    echo "# 3. TAC"
    echo "# 4. PROSYNC"
    echo "# 5. TAS"
    echo -n "Choose the Number : "
}

function FN_AUTO_MENU(){
    echo "AUTO"
}

function FN_MANUAL_MENU(){
    echo " -----------------------------------------------------------------------------------"
    echo "  1.TIBERO USER CREATE                    |  2.TIBERO User Profile                  "
    echo " ---------------------------------------- + ----------------------------------------"
    echo "  11 - MANUAL                             |  21 - MANUAL                            "
    echo "                                          |                                         "
    echo " -----------------------------------------------------------------------------------"
    echo "  3.TIBERO Directory                      |  4.TIBERO TIP                           "
    echo " ---------------------------------------- + ----------------------------------------"
    echo "  31 - MANUAL                             |  41 - MANUAL                            "
    echo "                                          |                                         "
    echo " -----------------------------------------------------------------------------------"
    echo "  5.TIBERO CREATE DATABASE                |  6.TIBERO CM Resource                   "
    echo " ---------------------------------------- + ----------------------------------------"
    echo "  51 - MANUAL                             |  61 - MANUAL                            "
    echo "                                          |                                         "
    echo " -----------------------------------------------------------------------------------"
    echo "  c  - Clear terminal                                                               "
    echo "  r  - retry main menu                                                              "
    echo "  Other key - exit                                                                  "
    echo " -----------------------------------------------------------------------------------"
    echo -n " Choose the Number or Command : "    

    read INPUT_NUMBER
    case $INPUT_NUMBER in
    11)
        clear
        echo -n "# GROUP NAME : "
        read INPUT_GROUPNM
        echo -n "# USER NAME : "
        read INPUT_USERNM
        echo -n "# USER HOME PATH : "
        read INPUT_HOMEPATH
        echo "-----------------------------------------------------------------"
        echo
        echo "groupadd $INPUT_GROUPNM"
        echo "useradd $INPUT_USERNM -d $INPUT_HOMEPATH -g $INPUT_GROUPNM"
        echo
        echo "-----------------------------------------------------------------"
        echo
        FN_PRINT_PRESS
        read PRESS_KEY
    ;;
    21)
        clear
        FN_PRINT_TYPE
        read INTPUT_TYPE
        echo -n "# USER NAME : "
        read INPUT_USER
        echo
        echo "# 1. .bash_profile"
        echo "# 2. .profile"
        echo -n "Choose the Number : "
        read INPUT_ENV
        FN_PRINT_PRESS
        read PRESS_KEY
    ;;
    31)
        clear
        FN_PRINT_TYPE
        FN_PRINT_PRESS
        read PRESS_KEY
    ;;
    41)
        clear
        FN_PRINT_TYPE
        FN_PRINT_PRESS
        read PRESS_KEY    
    ;;
    51)
        clear
        FN_PRINT_TYPE
        FN_PRINT_PRESS
        read PRESS_KEY
    ;;
    61)
        clear
        FN_PRINT_TYPE
        FN_PRINT_PRESS
        read PRESS_KEY
    ;;
    c|C)
        clear
        FN_MANUAL_MENU
    ;;
    r|R)
        clear
        FN_CHOICE_MENU
    ;;
    *)
        exit 1
    ;;
    esac
}

function FN_CHOICE_MENU(){
    echo "* TIBERO Installation Shell Script"
    echo "* This script is for Tibero "Daejeon Office" only."
    echo "1 AUTO SCRIPT"
    echo "2 MANUAL SCRIPT"
    read INPUT_NUMBER
    case $INPUT_NUMBER in 
    1)
        FN_AUTO_MENU
        exit
        ;;
    2)
        while true
        do
            FN_MANUAL_MENU
        done
    ;;
    *)
        exit
    ;;
    esac
}

FN_CHOICE_MENU