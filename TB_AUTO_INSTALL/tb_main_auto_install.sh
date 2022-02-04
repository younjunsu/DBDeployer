#!/bin/sh
############################################################
############################################################
TB_CNF_INI_FILE="tb_cnf_ini.sh"
TB_RESULT_FILE="./tb_files"
############################################################
############################################################

clear

function FN_PRINT_PRESS(){
    echo "Press Enter Key to continue..."
}
function FN_PRINT_TYPE(){
    echo "############################"
    echo "# TIBERO TYPE"
    echo "# 1. SINGLE"
    echo "# 2. TSC"
    echo "# 3. TAC"
    echo "# 4. PROSYNC"
    echo "# 5. TAS"
    echo "############################"
    echo -n "Choose the Number : "
}

function FN_AUTO_MENU(){
    echo "AUTO"
}

function FN_MANUAL_MENU(){
    clear
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
        echo
        echo "############################"
        echo -n "# USER NAME : "
        read INPUT_USER
        echo -n "# DB NAME : "
        read INPUT_DBNM
        echo -n "# CM_SID NAME : "
        read INPUT_CMNM
        echo -n "# TB_HOME PATH : "
        read INPUT_TBHOME
        echo
        echo "############################"
        echo "# ENV Prrofile Select"
        echo "# 1. .bash_profile"
        echo "# 2. .profile"
        echo "############################"
        echo -n "Choose the Number : "
        read INPUT_ENV
        echo
        USER_HOME_PATH=`echo $USER_HOME_PATH |sed 's/=/ /g' |awk '{print $NF}'`
        case $INPUT_ENV in 
        1)
            echo "-----------------------------------------------------------------"
            echo
            sh $TB_CNF_INI_FILE PROFILE $INTPUT_TYPE $INPUT_TBHOME $INPUT_DBNM $INPUT_CMNM
            echo "cat $TB_RESULT_FILE/TIBERO_PROFILE_RESULT.txt >> "$USER_HOME_PATH"/.bash_profile"
            echo
            echo "-----------------------------------------------------------------"            
        ;;
        2)
            echo "-----------------------------------------------------------------"
            echo
            echo "cat ./tb_files/tb_profile.txt >> "$USER_HOME_PATH"/.profile"
            echo
            echo "-----------------------------------------------------------------"
        ;;
        *)
            ""
        ;;
        esac

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



## Main Progress
function FN_CHOICE_MENU(){
    echo "* TIBERO Installation Shell Script"
    echo "* This script is for TmaxTibero "Daejeon Office" only."
    echo "1 AUTO SCRIPT"
    echo "2 MANUAL SCRIPT"
    read INPUT_NUMBER
    case $INPUT_NUMBER in 
    1)
        FN_AUTO_MENU
        exit 1
        ;;
    2)
        while true
        do
            FN_MANUAL_MENU
        done
    ;;
    *)
        exit 1
    ;;
    esac
}

FN_CHOICE_MENU