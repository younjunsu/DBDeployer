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
        export PRINT_TYPE_DETAIL_TYPE="SINGLE"        
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
            echo
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
            echo ""
            echo "-----------------------------------------------------------------"
            echo "# AIX "
            echo ""
            echo "mkgroup $INPUT_GROUP_NAME"
            echo "useradd $INPUT_USER_NAME -d $INPUT_USER_HOME_PATH -g $INPUT_GROUP_NAME -u $INPUT_USER_UID"
            echo "-----------------------------------------------------------------"
            echo ""
            echo ""
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
        printf "# DB_NAME : "
        read INPUT_DB_NAME
        export INPUT_DB_NAME=$INPUT_DB_NAME
        printf "# TB_HOME PATH : "
        read INPUT_TB_HOME_PATH
        export INPUT_TB_HOME_PATH=$INPUT_TB_HOME_PATH
        echo ""
        echo "-----------------------------------------------------------------"
        echo ""
        sh tbis_ini.sh USER_PROFILE $PRINT_TYPE_INPUT_TYPE $PRINT_TYPE_DETAIL_TYPE
        echo ""
        echo "-----------------------------------------------------------------"            
        echo ""
        FN_PRINT_PRESS
        read PRESS_KEY
    ;;
    31)
        clear
        FN_PRINT_TYPE
        echo "---------------------------"
        echo "TB_SID.tip Manual Configuation"
        echo "---------------------------"        
        printf "# DB_NAME : "
        read INPUT_DB_NAME
        export INPUT_DB_NAME=$INPUT_DB_NAME
        printf "# TB_HOME PATH : "
        read INPUT_TB_HOME_PATH        
        export INPUT_TB_HOME_PATH=$INPUT_TB_HOME_PATH
        printf "# CONTROL_FILES_PATH1 Disk Partition : "
        read INPUT_CONTROL_FILES_PATH1
        export INPUT_CONTROL_FILES_PATH1=$INPUT_CONTROL_FILES_PATH1
        printf "# CONTROL_FILES_PATH2 Disk Partition : "
        read INPUT_CONTROL_FILES_PATH2
        export INPUT_CONTROL_FILES_PATH2=$INPUT_CONTROL_FILES_PATH2
        printf "# DB_CREATE_FILE_DEST Disk Partition : "
        read INPUT_DB_CREATE_FILE_DEST
        export INPUT_DB_CREATE_FILE_DEST=$INPUT_DB_CREATE_FILE_DEST
        printf "# LOG_ARCHIVE_DEST Disk Partition : "
        read INPUT_LOG_ARCHIVE_DEST
        export INPUT_LOG_ARCHIVE_DEST=$INPUT_LOG_ARCHIVE_DEST
        if [ $PRINT_TYPE_INPUT_TYPE == "1" ]
        then
            2>/dev/null
        elif [ $PRINT_TYPE_INPUT_TYPE == "2" ]
        then
            printf "# Primary Interconnect IP : "
            read INPUT_NODE1_INTER_IP
            export INPUT_NODE1_INTER_IP=$INPUT_NODE1_INTER_IP
            printf "# Standby Interconnect IP : "
            read INPUT_NODE2_INTER_IP
            export INPUT_NODE2_INTER_IP=$INPUT_NODE2_INTER_IP
        elif [ $PRINT_TYPE_INPUT_TYPE == "3" ] && [ $PRINT_TYPE_DETAIL_TYPE == "1" ]
        then
            printf "# cm0 Interconnect IP : "
            read INPUT_NODE1_INTER_IP
            export INPUT_NODE1_INTER_IP=$INPUT_NODE1_INTER_IP
        elif [ $PRINT_TYPE_INPUT_TYPE == "3" ] && [ $PRINT_TYPE_DETAIL_TYPE == "2" ]
        then
            printf "# cm1 Interconnect IP : "
            read INPUT_NODE2_INTER_IP
            export INPUT_NODE2_INTER_IP=$INPUT_NODE2_INTER_IP
        fi

        echo ""
        echo "-----------------------------------------------------------------"
        echo ""
        sh tbis_ini.sh TB_SID_TIP $PRINT_TYPE_INPUT_TYPE $PRINT_TYPE_DETAIL_TYPE
        echo ""
        echo "-----------------------------------------------------------------"            
        echo ""
        FN_PRINT_PRESS
        read PRESS_KEY
    ;;
    41)
        clear
        FN_PRINT_TYPE
        echo "---------------------------"
        echo "CM_SID.tip Manual Configuation"
        echo "---------------------------"        
        printf "# DB_NAME : "
        read INPUT_DB_NAME
        export INPUT_DB_NAME=$INPUT_DB_NAME
        printf "# TB_HOME PATH : "
        read INPUT_TB_HOME_PATH
        export INPUT_TB_HOME_PATH=$INPUT_TB_HOME_PATH
        echo ""
        echo "-----------------------------------------------------------------"
        echo ""
        sh tbis_ini.sh CM_SID_TIP $PRINT_TYPE_INPUT_TYPE $PRINT_TYPE_DETAIL_TYPE
        echo ""
        echo "-----------------------------------------------------------------"            
        echo ""
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

FN_HOME_DIRECTORY(){
    mkdir -p $HOME/install/backup
    mkdir -p $HOME/install/binary
    touch $HOME/install/patch_info.txt
    mkdir -p $HOME/work
}

FN_SYSETM_CHECK(){
    clear
    echo "system check"
    FN_PRINT_PRESS
    read PRESS_KEY  
    FN_MAIN_MENU

}
FN_INITAILIZATION(){
    clear
    echo "Initialization"
    FN_PRINT_PRESS
    read PRESS_KEY  
    FN_MAIN_MENU
}


# Type Select (auto)
AUTO_PRINT_TYPE(){ 
    clear
    echo "---------------------------"
    echo "# 1. DB INSTALL"
    echo "# 2. CANCLE"
    echo "---------------------------"
    echo "# press other key to quit"
    echo "---------------------------"
    printf "Choose the Number : "
    read PRINT_TYPE_INPUT_TYPE
    echo
    echo
    
    case $PRINT_TYPE_INPUT_TYPE in 
    1) 
        ###### PROFILE
        clear
        export INPUT_INI_TYPE=USER_PROFILE
        . ./tbis_ini.sh > /dev/null 2>&1
        
        
        echo "---------------------------"
        echo "# TYPE : $TIBERO_TYPE"
        echo "---------------------------"
        sh tbis_ini.sh USER_PROFILE > bash_profile
        cat bash_profile > $HOME/.bash_profile
        . $HOME/.bash_profile
        echo " "
        echo "PROFILE CREATE ... ok"
        echo " "

        
        ###### TIP FILE
        export INPUT_INI_TYPE=TB_SID_TIP
        sh tbis_ini.sh TB_SID_TIP > $TB_SID.tip
        mv $TB_HOME/config/$TB_SID.tip $TB_HOME/config/$TB_SID.tip_bak > /dev/null 2>&1
        cat $TB_SID.tip > $TB_HOME/config/$TB_SID.tip
        
        if [ $TIBERO_TYPE == "TSC" ]
        then
            echo ""
        elif [ $TIBERO_TYPE == "TAC" ]
        then
            if [ $TIBERO_NODE == "cm0" ]
            then
            export INPUT_INI_TYPE=CM_SID_TIP
            sh tbis_ini.sh CM_SID_TIP > $TIBERO_NODE.tip
            cat $TIBERO_NODE.tip > $TB_HOME/config/$TIBERO_NODE.tip
            elif [ $TIBERO_NODE == "cm1"]
            then
            export INPUT_INI_TYPE=CM_SID_TIP
            sh tbis_ini.sh CM_SID_TIP > $TIBERO_NODE.tip
            cat $TIBERO_NODE.tip > $TB_HOME/config/$TIBERO_NODE.tip
            fi
        fi
        echo "TIP FILE CREATE ... ok"
        echo " "

        ###### CRE DATABASE 
        export INPUT_INI_TYPE=CRE_DATABASE
        sh tbis_ini.sh CRE_DATABASE > cre_db.sql
        cat /dev/null > $TB_HOME/client/config/tbdsn.tbr > /dev/null 2>&1
      

        ###### TIBERO BOOT
        mkdir -p $DB_CREATE_FILE_DEST/system
        cat /dev/null > $TB_HOME/client/config/tbdsn.tbr
        sh $TB_HOME/config/gen_tip.sh > /dev/null 2>&1
        sed -i "s/(DB_NAME=.*/(DB_NAME=$DB_NAME)/g" $TB_HOME/client/config/tbdsn.tbr #테스트를 위한 임시 설정 변경 예정

        if [ $TIBERO_TYPE == "SINGLE" ]
        then
            tbboot nomount > /dev/null 2>&1
            tbsql sys/tibero @cre_db.sql > /dev/null 2>&1 <<EOF
            quit
EOF
        echo "CREATE DATABASE ... ok"
        echo " "
        tbboot > /dev/null 2>&1
        sh $TB_HOME/scripts/system.sh > /dev/null 2>&1 <<EOF
        tibero
        syscat
        Y
        Y
        Y
        Y
EOF
        elif [ $TIBERO_TYPE == "TSC" ]
        then
            echo ""
        elif [ $TIBERO_TYPE == "TAC" ]
        then
            if [ $TIBERO_NODE == "cm0" ]
            then
                tbcm -b > /dev/null 2>&1
                mkdir -p $DB_CREATE_FILE_DEST/CM
                export INPUT_INI_TYPE=CM_RESOURCE
                sh tbis_ini.sh CM_RESOURCE > $TIBERO_NODE\_resource
                sh $TIBERO_NODE\_resource > /dev/null 2>&1
                echo "CM0 RESOURCE ... ok"
                echo ""
                tbboot nomount  > /dev/null 2>&1
                tbsql sys/tibero @cre_db.sql > /dev/null 2>&1 <<EOF
                quit
EOF
                echo "CREATE DATABASE ... ok"
                echo " "
                tbboot > /dev/null 2>&1
                export INPUT_INI_TYPE=ADD_CRE_DATABASE
                sh tbis_ini.sh ADD_CRE_DATABASE > add_cre_db.sql
                tbsql sys/tibero @add_cre_db.sql > /dev/null 2>&1 << EOF
                quit
EOF
                sh $TB_HOME/scripts/system.sh > /dev/null 2>&1 <<EOF
                tibero
                syscat
                Y
                Y
                Y
                Y
EOF
            elif [ $TIBERO_NODE == "cm1"]
            then
            echo ""
            fi
        fi
        echo "TIBERO BOOT ... ok"

        echo " "
        FN_PRINT_PRESS
        read FN_PRINT_PRESS
    ;;
    2)
        FN_MAIN_MENU
    ;;
    *)
        clear
        echo "tb_install_shell.sh quit."
        exit
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
    echo "# chk. System Check"
    echo "# ini. Configurations Initialization"
    echo "# press other key to quit"
    echo "-----------------------------------------------------------------"
    printf "Choose the Number : "
    read INPUT_NUMBER
    case $INPUT_NUMBER in 
    1)
        AUTO_PRINT_TYPE
        #FN_AUTO_MENU
        exit 1
        ;;
    2)
        while true
        do
            FN_MANUAL_MENU
        done
    ;;
    ini)
        FN_INITAILIZATION
    ;;
    chk)
        FN_SYSETM_CHECK
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
FN_MAIN_MENU

# Debug mode
# FN_MAIN_MENU 
