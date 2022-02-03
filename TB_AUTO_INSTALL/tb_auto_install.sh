#!/bin/sh
clear
echo "* TIBERO Installation Shell Script"
echo "* This script is for Tibero "Daejeon Office" only."
echo "1 auto"
echo "2 manual"
read INPUT_NUMBER
case $INPUT_NUMBER in 
1)
    echo "AUTO SET"
    ;;
2)
    function MANUAL_MENU(){
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
        echo "  5.TIBERO CREATE DATABASE                |  6.TIBERO Cluster Resource              "
        echo " ---------------------------------------- + ----------------------------------------"
        echo "  51 - MANUAL                             |  61 - MANUAL                            "
        echo "                                          |                                         "
        echo " -----------------------------------------------------------------------------------"
        echo -n " Choose the Number or Command : "
    }
    MANUAL_MENU
    read INPUT_NUMBER
    case $INPUT_NUMBER in
    11)
        echo -n "# GROUP NAME : "
        read INPUT_GROUPNM
        echo -n "# USER NAME : "
        read INPUT_USERNM
        echo -n "# USER HOME PATH : "
        read INPUT_HOMEPATH
        echo "groupadd $INPUT_GROUPNM"
        echo "useradd $INPUT_USERNM -d $INPUT_HOMEPATH -g $INPUT_GROUPNM"
        MANUAL_MENU
    ;;
    21)
    ;;
    31)
    ;;
    41)
    ;;
    51)
    ;;
    61)
    ;;
    esac
;;
esac