#!/bin/sh
############################################################
#
# Program variables
############################################################
# Configuration file path
TB_CNF_INI_FILE="tb_cnf_ini.sh"
TB_RESULT_FILE="./tb_files"


############################################################
#
# Function lists
############################################################
# Press key
function FN_PRINT_PRESS(){
    echo "Press Enter Key to continue..."
}

# Type Select
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
    
    read INPUT_TYPE
    export INPUT_TYPE=$INPUT_TYPE
    
    # Type Select exception out
    if [ $INPUT_TYPE != "1" ] && [ $INPUT_TYPE != "2" ] && [ $INPUT_TYPE != "3" ] && [ $INPUT_TYPE != "4" ] && [ $INPUT_TYPE != "5" ]
    then
        exit 1
    fi
}

function FN_PRINT_TYPE_DETAIL(){
    TYPE=$INPUT_TYPE

    if [ $TYPE == "2" ]
    then
        echo "############################"
        echo "# TIBERO TSC DETAIL TYPE"
        echo "# 1. TSC Primary"
        echo "# 2. TSC Standby"
        echo "# 3. TSC Observer"
        echo "############################"
        echo -n "Choose the Number : "

        read INPUT_TYPE_DETAIL
        export INPUT_TYPE_DETAIL=$INPUT_TYPE_DETAIL
    elif [ $TYPE == "3" ]
    then
        echo "############################"
        echo "# TIBERO TAC DETAIL TYPE"
        echo "# 1. TAC THREAD 0"
        echo "# 2. TAC THREAD 1"
        echo "############################"
        echo -n "Choose the Number : "

        read INPUT_TYPE_DETAIL
        export INPUT_TYPE_DETAIL=$INPUT_TYPE_DETAIL        
    else
        exit 1
    fi


}

# Automatic menu
function FN_AUTOMATIC_MENU(){
    echo "FN_AUTOMATIC_MENU"
}

# Manual menu
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
        echo -n "# GROUP GID : "
        read INPUT_GROUPGID
        echo -n "# USER NAME : "
        read INPUT_USERNM
        echo -n "# USER UID : "
        read INPUT_USERUID
        if [ -z $INPUT_USERUID ] || [ -z $INPUT_GROUPGID ]
        then
            echo -n "# USER HOME PATH : "
            read INPUT_HOMEPATH
            echo "-----------------------------------------------------------------"
            echo "# LINUX | HP-UX | Solaris"
            echo
            echo "groupadd $INPUT_GROUPNM"
            echo "useradd $INPUT_USERNM -d $INPUT_HOMEPATH -g $INPUT_GROUPNM"
            echo
            echo "-----------------------------------------------------------------"
            echo "# AIX "
            echo 
            echo
            echo "-----------------------------------------------------------------"
            echo
            echo
            FN_PRINT_PRESS
            read PRESS_KEY        
        else
            echo -n "# USER HOME PATH : "
            read INPUT_HOMEPATH
            echo "-----------------------------------------------------------------"
            echo "# LINUX | HP-UX | Solaris"
            echo
            echo "groupadd $INPUT_GROUPNM -g $INPUT_GROUPGID"
            echo "useradd $INPUT_USERNM -d $INPUT_HOMEPATH -g $INPUT_GROUPNM -u $INPUT_USERUID"
            echo
            echo "-----------------------------------------------------------------"
            echo "# AIX "
            echo 
            echo
            echo "-----------------------------------------------------------------"
            echo
            echo
            FN_PRINT_PRESS
            read PRESS_KEY
        fi

    ;;
    21)
        clear
        FN_PRINT_TYPE      

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
        USER_HOME_PATH=`echo $USER_HOME_PATH |sed 's/=/ /g' |awk '{print $NF}'`
        echo "-----------------------------------------------------------------"
        echo "# .bash_profile"
        echo
        sh $TB_CNF_INI_FILE PROFILE $INPUT_TYPE $INPUT_TBHOME $INPUT_DBNM $INPUT_CMNM
        echo "cat $TB_RESULT_FILE/TIBERO_PROFILE_RESULT.txt >> "$USER_HOME_PATH"/.bash_profile"
        echo
        echo "# Checking for command"
        echo "cat "$USER_HOME_PATH"/.bash_profile"
        echo
        echo "-----------------------------------------------------------------"            
        echo
        echo "-----------------------------------------------------------------"
        echo "# .profile"
        echo
        echo "cat ./tb_files/tb_profile.txt >> "$USER_HOME_PATH"/.profile"
        echo
        echo "# Checking for command"
        echo "cat  "$USER_HOME_PATH"/.profile"
        echo
        echo "-----------------------------------------------------------------"
        echo
        echo
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

# Main function
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

############################################################
#
# Main function running
############################################################
clear
FN_CHOICE_MENU