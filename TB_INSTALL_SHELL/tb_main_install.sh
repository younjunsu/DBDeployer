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
# lists
############################################################
# Press key
FN_PRINT_PRESS(){
    echo "Press Enter Key to continue..."
}

# Type Select
FN_PRINT_TYPE(){
    echo "---------------------------"
    echo "# TIBERO TYPE"
    echo "# 1. SINGLE"
    echo "# 2. TSC"
    echo "# 3. TAC"
    echo "# 4. TAS"
    echo "# m. Mnaul menu screen"
    echo "# press other key to quit"
    echo "---------------------------"
    printf "Choose the Number : "
    read PRINT_TYPE_INPUT_TYPE
    echo
    echo
    echo "---------------------------"
    case $PRINT_TYPE_INPUT_TYPE in
    1)
        echo "# TYPE : SINGLE"
        export PRINT_TYPE_INPUT_TYPE=$PRINT_TYPE_INPUT_TYPE
    ;;
    2)
        echo "# TYPE : TSC"
        export PRINT_TYPE_INPUT_TYPE=$PRINT_TYPE_INPUT_TYPE
    ;;
    3)
        echo "# TYPE : TAC"
       export PRINT_TYPE_INPUT_TYPE=$PRINT_TYPE_INPUT_TYPE
    ;;
    4)
        echo "# TYPE : TAS"
        export PRINT_TYPE_INPUT_TYPE=$PRINT_TYPE_INPUT_TYPE
    ;;
    m)
        FN_MANUAL_MENU
    ;;
    *)
        clear
        echo "tb_install_shell.sh quit."
        exit 1
    ;;
    esac
}

FN_PRINT_TYPE_DETAIL(){
    PRINT_TYPE_DETAIL_TYPE=$PRINT_TYPE_INPUT_TYPE

    if [ $TYPE == "2" ]
    then
        echo "---------------------------"
        echo "# TIBERO TSC DETAIL TYPE"
        echo "# 1. TSC Primary"
        echo "# 2. TSC Standby"
        echo "# 3. TSC Observer"
        echo "# m. Mnaul menu screen"
        echo "# press other key to quit"
        echo "---------------------------"
        printf "Choose the Number : "

        read PRINT_TYPE_DETAIL_TYPE
        export PRINT_TYPE_DETAIL_TYPE=$PRINT_TYPE_DETAIL_TYPE
    elif [ $TYPE == "3" ]
    then
        echo "---------------------------"
        echo "# TIBERO TAC DETAIL TYPE"
        echo "# 1. TAC THREAD 0"
        echo "# 2. TAC THREAD 1"
        echo "# m. Mnaul menu screen"
        echo "---------------------------"
        printf "Choose the Number : "

        read PRINT_TYPE_DETAIL_TYPE
        export PRINT_TYPE_DETAIL_TYPE=$PRINT_TYPE_DETAIL_TYPE        
    else
        exit 1
    fi
}

# Automatic menu
FN_AUTOMATIC_MENU(){
    echo "FN_AUTOMATIC_MENU"
}
FN_CALL_MANUAL_MENU(){
    FN_MANUAL_MENU
}

# Manual menu
FN_MANUAL_MENU(){
    clear
    echo " -----------------------------------------------------------------------------------"
    echo "  1.TIBERO USER CREATE                      |  2.TIBERO User Profile                  "
    echo " ---------------------------------------- + ----------------------------------------"
    echo "  # 11 - MANUAL                             |  # 21 - MANUAL                            "
    echo "                                            |                                         "
    echo " -----------------------------------------------------------------------------------"
    echo "  3.TIBERO Directory                        |  4.TIBERO TIP                           "
    echo " ---------------------------------------- + ----------------------------------------"
    echo "  # 31 - MANUAL                             |  # 41 - MANUAL                            "
    echo "                                            |                                         "
    echo " -----------------------------------------------------------------------------------"
    echo "  5.TIBERO CREATE DATABASE                  |  6.TIBERO CM Resource                   "
    echo " ---------------------------------------- + ----------------------------------------"
    echo "  # 51 - MANUAL                             |  # 61 - MANUAL                            "
    echo "                                            |                                         "
    echo " -----------------------------------------------------------------------------------"
    echo "  c  - Clear terminal                                                               "
    echo "  r  - retry main menu                                                              "
    echo "  press other key to quit                                                                  "
    echo " -----------------------------------------------------------------------------------"
    printf " Choose the Number or Command : "    

    read INPUT_NUMBER
    case $INPUT_NUMBER in
    11)
        clear
        echo "-----------------------------------------------------------------"
        echo "# /etc/group"
        cat /etc/group |tail -n 5
        echo "-----------------------------------------------------------------"
        echo
        printf "# GROUP NAME : "
        read INPUT_GROUPNM
        printf "# GROUP GID : "
        read INPUT_GROUPGID
        echo
        echo "-----------------------------------------------------------------"
        echo "# /etc/passwd"
        cat /etc/passwd |tail -n 5
        echo "-----------------------------------------------------------------"
        echo
        printf "# USER NAME : "
        read INPUT_USERNM
        printf "# USER UID : "
        read INPUT_USERUID
        printf "# USER HOME PATH : "
        read INPUT_HOMEPATH
        echo
        echo
        clear
        if [ -z $INPUT_USERUID ] || [ -z $INPUT_GROUPGID ]
        then
            echo "-----------------------------------------------------------------"
            echo "# OS USER/GROUP Result"
            echo "-----------------------------------------------------------------"
            echo "# LINUX | HP-UX | Solaris"
            echo
            echo "groupadd $INPUT_GROUPNM"
            echo "useradd $INPUT_USERNM -d $INPUT_HOMEPATH -g $INPUT_GROUPNM"
            echo
            echo "-----------------------------------------------------------------"
            echo "# AIX "
            echo "mkgroup $INPUT_GROUPNM"
            echo "useradd $INPUT_USERNM -d $INPUT_HOMEPATH -g $INPUT_GROUPNM"
            echo "-----------------------------------------------------------------"
            echo
            echo
            FN_PRINT_PRESS
            read PRESS_KEY        
        else
            echo "-----------------------------------------------------------------"
            echo "# USER/GROUP Result"
            echo "-----------------------------------------------------------------"
            echo "# LINUX | HP-UX | Solaris"
            echo
            echo "groupadd $INPUT_GROUPNM -g $INPUT_GROUPGID"
            echo "useradd $INPUT_USERNM -d $INPUT_HOMEPATH -g $INPUT_GROUPNM -u $INPUT_USERUID"
            echo
            echo "-----------------------------------------------------------------"
            echo "# AIX "
            echo "mkgroup $INPUT_GROUPNM -A id=$INPUT_GROUPGID"
            echo "useradd $INPUT_USERNM -d $INPUT_HOMEPATH -g $INPUT_GROUPNM -u $INPUT_USERUID"
            echo "-----------------------------------------------------------------"
            echo
            echo
            FN_PRINT_PRESS
            read PRESS_KEY
        fi
        FN_CALL_MANUAL_MENU
    ;;
    21)
        clear
        FN_PRINT_TYPE      
        echo "---------------------------"
        printf "# USER NAME : "
        read INPUT_USER
        printf "# DB NAME : "
        read INPUT_DBNM
        printf "# CM_SID NAME : "
        read INPUT_CMNM
        printf "# TB_HOME PATH : "
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
        clear
        echo "tb_install_shell.sh quit."
        exit 1
    ;;
    esac
}

# Main function
FN_CHOICE_MENU(){
    echo "* TIBERO Installation Shell Script"
    echo "* This script is for TmaxTibero "Daejeon Office" only."
    echo "-----------------------------------------------------------------"
    echo "# 1 AUTO SCRIPT"
    echo "# 2 MANUAL SCRIPT"
    echo "# press other key to quit"
    echo "-----------------------------------------------------------------"
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
        clear
        echo "tb_install_shell.sh quit."
        exit 1
    ;;
    esac
}

############################################################
#
# Main running
############################################################
clear
FN_CHOICE_MENU 2>/dev/null