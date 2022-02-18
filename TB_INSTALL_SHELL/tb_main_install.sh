#!/bin/sh
############################################################
#
# Program history
############################################################
# Created by. Daejeon Office
# 2022.03.18 Version : Park Si Hyung, Yoon Jun Su
#



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
    echo "---------------------------"
    echo "# m. Mnaul menu screen"
    echo "# press other key to quit"
    echo "---------------------------"
    printf "Choose the Number : "
    read PRINT_TYPE_INPUT_TYPE
    echo
    echo
    case $PRINT_TYPE_INPUT_TYPE in
    1)
        clear
        export PRINT_TYPE_INPUT_TYPE=$PRINT_TYPE_INPUT_TYPE
        echo "---------------------------"
        echo "# TYPE : SINGLE"
        FN_PRINT_TYPE_DETAIL
        
    ;;
    2)
        clear
        export PRINT_TYPE_INPUT_TYPE=$PRINT_TYPE_INPUT_TYPE
        echo "---------------------------"
        echo "# TYPE : TSC"
        FN_PRINT_TYPE_DETAIL
        
    ;;
    3)
        clear
        export PRINT_TYPE_INPUT_TYPE=$PRINT_TYPE_INPUT_TYPE
        echo "---------------------------"
        echo "# TYPE : TAC"
        FN_PRINT_TYPE_DETAIL
        
    ;;
    4)
        clear
        export PRINT_TYPE_INPUT_TYPE=$PRINT_TYPE_INPUT_TYPE
        echo "---------------------------"
        echo "# TYPE : TAS"
        
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
    export PRINT_TYPE_INPUT_TYPE=$PRINT_TYPE_INPUT_TYPE

    case $PRINT_TYPE_INPUT_TYPE in
    1)
        # SINGLE
        2>/dev/null
    ;;
    2)
        echo "---------------------------"
        echo "# TIBERO TSC detail type"
        echo "# 1. TSC Primary"
        echo "# 2. TSC Standby"
        echo "# 3. TSC Observer"
        echo "---------------------------"
        echo "# m. Mnaul menu screen"
        echo "# press other key to quit"
        echo "---------------------------"
        printf "Choose the Number : "

        read PRINT_TYPE_DETAIL_TYPE
        export PRINT_TYPE_DETAIL_TYPE=$PRINT_TYPE_DETAIL_TYPE        
    ;;
    3)
        echo "---------------------------"
        echo "# TIBERO TAC detail type"
        echo "# 1. TAC THREAD 0"
        echo "# 2. TAC THREAD 1"
        echo "---------------------------"
        echo "# m. Mnaul menu screen"
        echo "# press other key to quit"
        echo "---------------------------"
        printf "Choose the Number : "

        read PRINT_TYPE_DETAIL_TYPE
        export PRINT_TYPE_DETAIL_TYPE=$PRINT_TYPE_DETAIL_TYPE        
    ;;
    4)
        echo
    ;;
    *)
        exit 1
    ;;
    esac
}

FN_AUTOMATIC_MENU(){
    echo "FN_AUTOMATIC_MENU"
}

FN_CALL_MANUAL_MENU(){
    FN_MANUAL_MENU
}

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
        read INPUT_GROUP_NAME
        printf "# GROUP GID : "
        read INPUT_GROUP_GID
        echo
        echo "-----------------------------------------------------------------"
        echo "# /etc/passwd"
        cat /etc/passwd |tail -n 5
        echo "-----------------------------------------------------------------"
        echo
        printf "# USER NAME : "
        read INPUT_USER_NAME
        printf "# USER UID : "
        read INPUT_USER_UID
        printf "# USER HOME PATH : "
        read INPUT_USER_HOME_PATH
        echo
        echo
        clear
        if [ -z $INPUT_USER_UID ] && [ -z $INPUT_GROUP_GID ]
        then
            echo "-----------------------------------------------------------------"
            echo "# OS USER/GROUP Result"
            echo "-----------------------------------------------------------------"
            echo "# LINUX | HP-UX | Solaris"
            echo
            echo "groupadd $INPUT_GROUP_NAME"
            echo "useradd $INPUT_USER_NAME -d $INPUT_USER_HOME_PATH -g $INPUT_GROUP_NAME"
            echo
            echo "-----------------------------------------------------------------"
            echo "# AIX "
            echo "mkgroup $INPUT_GROUP_NAME"
            echo "useradd $INPUT_USER_NAME -d $INPUT_USER_HOME_PATH -g $INPUT_GROUP_NAME"
            echo "-----------------------------------------------------------------"
            echo
            echo
            FN_PRINT_PRESS
            read PRESS_KEY        
        elif [ -z $INPUT_USER_UID ]
        then
            echo "-----------------------------------------------------------------"
            echo "# USER/GROUP Result"
            echo "-----------------------------------------------------------------"
            echo "# LINUX | HP-UX | Solaris"
            echo
            echo "groupadd $INPUT_GROUP_NAME -g $INPUT_GROUP_GID"
            echo "useradd $INPUT_USER_NAME -d $INPUT_USER_HOME_PATH -g $INPUT_GROUP_NAME"
            echo
            echo "-----------------------------------------------------------------"
            echo "# AIX "
            echo "mkgroup $INPUT_GROUP_NAME -A id=$INPUT_GROUP_GID"
            echo "useradd $INPUT_USER_NAME -d $INPUT_USER_HOME_PATH -g $INPUT_GROUP_NAME"
            echo "-----------------------------------------------------------------"
            echo
            echo
            FN_PRINT_PRESS
            read PRESS_KEY
        elif  [ -z $INPUT_GROUP_GID ]
        then
            echo "-----------------------------------------------------------------"
            echo "# USER/GROUP Result"
            echo "-----------------------------------------------------------------"
            echo "# LINUX | HP-UX | Solaris"
            echo
            echo "groupadd $INPUT_GROUP_NAME"
            echo "useradd $INPUT_USER_NAME -d $INPUT_USER_HOME_PATH -g $INPUT_GROUP_NAME -u $INPUT_USER_UID"
            echo
            echo "-----------------------------------------------------------------"
            echo "# AIX "
            echo "mkgroup $INPUT_GROUP_NAME"
            echo "useradd $INPUT_USER_NAME -d $INPUT_USER_HOME_PATH -g $INPUT_GROUP_NAME -u $INPUT_USER_UID"
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
            echo "groupadd $INPUT_GROUP_NAME -g $INPUT_GROUP_GID"
            echo "useradd $INPUT_USER_NAME -d $INPUT_USER_HOME_PATH -g $INPUT_GROUP_NAME -u $INPUT_USER_UID"
            echo
            echo "-----------------------------------------------------------------"
            echo "# AIX "
            echo "mkgroup $INPUT_GROUP_NAME -A id=$INPUT_GROUP_GID"
            echo "useradd $INPUT_USER_NAME -d $INPUT_USER_HOME_PATH -g $INPUT_GROUP_NAME -u $INPUT_USER_UID"
            echo "-----------------------------------------------------------------"
            echo
            echo
            FN_PRINT_PRESS
            read PRESS_KEY
        fi
        FN_MANUAL_MENU
    ;;
    21)
        clear
        FN_PRINT_TYPE      
        echo "---------------------------"
        echo "Profile Manual Configuation"
        echo "---------------------------"
        #printf "# USER NAME : "
        #read INPUT_USER_NAME
        printf "# TB_SID : "
        read INPUT_TB_SID
        
        if [ $PRINT_TYPE_INPUT_TYPE == "1" ]
        then
            2>/dev/null
        else
            printf "# CM_SID NAME : "
            read INPUT_CM_NAME
        fi
        printf "# TB_HOME PATH : "
        read INPUT_TB_HOME_PATH
        echo
        echo "-----------------------------------------------------------------"
        echo
        sh $TB_CNF_INI_FILE PROFILE $PRINT_TYPE_INPUT_TYPE $INPUT_TB_HOME_PATH $INPUT_TB_SID $INPUT_CM_NAME
        echo
        echo "-----------------------------------------------------------------"            

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
        FN_MAIN_MENU
    ;;
    *)
        clear
        echo "tb_install_shell.sh quit."
        exit 1
    ;;
    esac
}

# Main function
FN_MAIN_MENU(){
    clear
    echo "[*] TIBERO Installation Shell Script"
    echo "[*] This script is for TmaxTibero "Daejeon Office" only."
    echo "[*] Supported Version : Tibero 6 FS07 ↑"
    echo "-----------------------------------------------------------------"
    echo "# 1. AUTO"
    echo "# 2. MANUAL"
    echo "-----------------------------------------------------------------"
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
# Program start
############################################################
# Normal mode
FN_MAIN_MENU 2>/dev/null

# Debug mode
# FN_MAIN_MENU 