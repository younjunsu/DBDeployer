#!/bin/sh

############################################################
#
# Program variables
############################################################
# Initialization
#export FN_PROFILE_RESULT_FILE="./tb_files/TIBERO_PROFILE_RESULT.txt"
#echo "" > $FN_PROFILE_RESULT_FILE

# Functions Parameters
INPUT_INI_TYPE=$1
INPUT_TB_TYPE=$2
INPUT_TB_DETAIL_TYPE=$3
INPUT_TB_HOME=$4
INPUT_TB_SID=$5
INPUT_TB_DB_NAME=$6


############################# AUTO Profile
AUTO_FN_USER_PROFILE(){
    echo "#############################"
    echo "# TIBERO environment variable"
    echo "#############################"
    echo "# .bash_profile"
    echo "# Get the aliases and functions"
    echo "if [ -f ~/.bashrc ]; then"
    echo ". ~/.bashrc"
    echo "fi"
    echo "PATH=\$PATH:\$HOME/.local/bin:\$HOME/bin"

    echo "export PATH"
    
    echo "#### SHELL"
    echo "stty erase ^H"
    echo "export PS1="[\`whoami\`@\`hostname\`:\$PWD]\$ ""
    echo "export EDITOR=vim"
    echo ""
    echo "#### JAVA"
    echo "#export JAVA_HOME="
    echo ""
    echo "#### SINGLE"
    echo "export TB_SID=$INPUT_TB_SID"
    echo "export TB_HOME=$INPUT_TB_HOME"
    echo "export TB_PROF_DIR=\$TB_HOME/bin/prof"
    echo "export LD_LIBRARY_PATH=\$TB_HOME/lib:\$TB_HOME/client/lib"
    echo "export LIBPATH=\$LD_LIBRARY_PATH"
    echo "export SHLIB_PATH=\$LD_LIBRARY_PATH"
    echo "export PATH=\$PATH:\$TB_HOME/bin:\$TB_HOME/client/bin:\$JAVA_HOME/bin"
    echo ""
    echo ""
    if [ $INPUT_TB_TYPE == "1" ]
    then
        2>/dev/null
    elif [ $INPUT_TB_TYPE == "2" ]
    then
        echo "#### TSC (Tibero Standby Cluster)"
        if [ $INPUT_TB_DETAIL_TYPE == "1" ]
        then
            echo "export CM_SID=primary"
            echo "export CM_HOME=$TB_HOME"
        elif [ $INPUT_TB_DETAIL_TYPE == "2" ]
        then
            echo "export CM_SID=standby"
            echo "export CM_HOME=$TB_HOME"
        elif [ $INPUT_TB_DETAIL_TYPE == "3" ]
        then
            echo "export CM_SID=observer"
            echo "export CM_HOME=$TB_HOME"
        else
            2>/dev/null
        fi
    elif [ $INPUT_TB_TYPE == "3" ]
    then
        echo "#### TAC (Tibero Active Cluster)"
        if [ $INPUT_TB_DETAIL_TYPE == "1" ]
        then
            echo "export CM_SID=cm0"
            echo "export CM_HOME=$TB_HOME"
        elif [ $INPUT_TB_DETAIL_TYPE == "2" ]
        then
            echo "export CM_SID=cm1"
            echo "export CM_HOME=$TB_HOME"
        else
            2>dev/null
        fi
    elif [ $InPUT_TB_TYPE == "4" ]PRINT_TYPE_INPUT_TYPE
    
    then
        2>/dev/null
    else
        2>/dev/null
    fi
    
    FN_USER_PROFILE_ALIAS
}

############################# TB_SID.tip
AUTO_FN_TB_SID_TIP(){
    echo "############ TIBERO genernal"
    echo "#### Must"
    echo "DB_NAME=$INPUT_DB_NAME"
    echo "LISTENER_PORT=8629"
    echo "CONTROL_FILES=$INPUT_CONTROL_FILES_PATH1/tbctl1/c1.ctl, $INPUT_CONTROL_FILES_PATH1/tbctl2/c2.ctl"
    echo "DB_CREATE_FILE_DEST=$INPUT_DB_CREATE_FILE_DEST/tbdata/"
    echo "LOG_ARCHIVE_DEST=$INPUT_LOG_ARCHIVE_DEST/tbarch/"
    echo "MAX_SESSION_COUNT=20"
    echo "TOTAL_SHM_SIZE=`free -m | grep ^Mem | awk '{print $2}'`"
    echo "MEMORY_TARGET=`free -m | grep ^Mem | awk '{print $2/2}'`"

    echo "############ TFT Parameters"
    echo "#### Must"
    echo "USE_TS_QUOTA=N"
    echo "AUTHENTICATION_TIMEOUT=100"
    echo "DBLINK_CONN_TIMEOUT=100"
    echo "TPR_SNAPSHOT_RETENTION=30"
    echo "TPR_SNAPSHOT_TOP_SQL_CNT=10"
    echo "GATHER_SQL_EXEC_TIME=Y"
    echo "GATHER_SQL_PLAN_STAT=Y"
    echo "SLOG_TOTAL_SIZE_LIMIT=1G"
    echo "_SLOG_DISPLAY_YEAR=Y"
    echo "AUDIT_SYS_OPERATIONS=Y"
    echo "AUDIT_TRAIL=OS"

    echo "#### Recommand"
    echo "#BOOT_WITH_AUTO_DOWN_CLEAN=Y"
    echo "#USE_RECYCLEBIN=Y"
    echo "#LOG_DEFAULT_DEST="
    echo "#ACT_LOG_DEST="
    echo "#CALLSTACK_DUMP_DEST="
    echo "## IMS224485 - 2022.01.27"
    echo "#_STANDBY_NETWORK_TIMEOUT=90"

    if [ $INPUT_TB_TYPE == "1" ]
    then
        2>/dev/null
    elif [ $INPUT_TB_TYPE == "2" ]
    then
        echo "############ TSC (Tibero Standby Cluster)"
        echo "#### Must"
        echo "CM_PORT=28629"
        echo "STANDBY_USE_OBSERVER=Y"
        echo "LOG_REPLICATION_MODE=PERFORMANCE"
        echo "LOCAL_CLUSTER_PORT=18629"
        if [ $INPUT_TB_DETAIL_TYPE == "1" ]
        then
            echo "## Primary"
            echo "LOG_REPLICATION_DEST_1=\"<Standby IP>:8633 LGWR ASYNC\""
            echo "LOCAL_CLUSTER_ADDR=<Primary IP>"
        elif [ $INPUT_TB_DETAIL_TYPE == "2" ]
        then
            echo "## Standny"
            echo "LOG_REPLICATION_DEST_1=\"<Primary IP>:8633 LGWR ASYNC\""
            echo "LOCAL_CLUSTER_ADDR=<Standby IP>"
        elif [ $INPUT_TB_DETAIL_TYPE == "3" ]
        then
            2>/dev/null
        fi
    elif [ $INPUT_TB_TYPE == "3" ]
    then
        echo "############ TAC (Tibero Active Cluster)"
        echo "#### Must"
        echo "CLUSTER_DATABASE=Y"
        echo "_USE_O_DIRECT=Y"
        if [ $INPUT_TB_DETAIL_TYPE == "1" ]
        then
            echo "## cm0"
            echo "THREAD=0"
            echo "UNDO_TABLESPACE=UNDO0"
            echo "CM_NAME=cm0"
            echo "CM_PORT=28629"
            echo "LOCAL_CLUSTER_ADDR=<localhost IP>"
            echo "LOCAL_CLUSTER_PORT=18629"
        elif [ $INPUT_TB_DETAIL_TYPE == "2" ]
        then
            echo "## cm1"
            echo "THREAD=1"
            echo "UNDO_TABLESPACE=UNDO1"
            echo "CM_NAME=cm1"
            echo "CM_PORT=28629"
            echo "LOCAL_CLUSTER_ADDR=<localhost IP>"
            echo "LOCAL_CLUSTER_PORT=18629"
        fi
    elif [ $InPUT_TB_TYPE == "4" ]
    then 
        2>/dev/null
    fi
}

############################# Profile
FN_USER_PROFILE_ALIAS(){
    echo "#### TIBERO Alias"
    echo "alias tbhome='cd \$TB_HOME'"
    echo "alias tbbin='cd \$TB_HOME/bin'"
    echo "alias tblog='cd \$TB_HOME/instance/\$TB_SID/log'"
    echo "alias tbcfg='cd \$TB_HOME/config'"
    echo "alias tbcfgv='vi \$TB_HOME/config/\$TB_SID.tip'"
    echo "alias tbcli='cd \$TB_HOME/client/config'"
    echo "alias tbcliv='vi \$TB_HOME/client/config/tbdsn.tbr'"
    echo "alias tm='\$HOME/tbinary/monitor/monitor'"
    echo "alias tbi='cd \$HOME/tbinary'"
}

FN_USER_PROFILE(){
    echo "#############################"
    echo "# TIBERO environment variable"
    echo "#############################"
    echo "# .bash_profile"
    echo "# Get the aliases and functions"
    echo "if [ -f ~/.bashrc ]; then"
    echo ". ~/.bashrc"
    echo "fi"
    echo "PATH=\$PATH:\$HOME/.local/bin:\$HOME/bin"

    echo "export PATH"
    
    echo "#### SHELL"
    echo "stty erase ^H"
    echo "export PS1="[\`whoami\`@\`hostname\`:\$PWD]\$ ""
    echo "export EDITOR=vim"
    echo ""
    echo "#### JAVA"
    echo "#export JAVA_HOME="
    echo ""
    echo "#### SINGLE"
    echo "export TB_SID=$INPUT_TB_SID"
    echo "export TB_HOME=$INPUT_TB_HOME"
    echo "export TB_PROF_DIR=\$TB_HOME/bin/prof"
    echo "export LD_LIBRARY_PATH=\$TB_HOME/lib:$TB_HOME/client/lib"
    echo "export LIBPATH=\$LD_LIBRARY_PATH"
    echo "export SHLIB_PATH=\$LD_LIBRARY_PATH"
    echo "export PATH=\$PATH:\$TB_HOME/bin:\$TB_HOME/client/bin:\$JAVA_HOME/bin"
    echo ""
    echo ""
    if [ $INPUT_TB_TYPE == "1" ]
    then
        2>/dev/null
    elif [ $INPUT_TB_TYPE == "2" ]
    then
        echo "#### TSC (Tibero Standby Cluster)"
        if [ $INPUT_TB_DETAIL_TYPE == "1" ]
        then
            echo "export CM_SID=primary"
            echo "export CM_HOME=$TB_HOME"
        elif [ $INPUT_TB_DETAIL_TYPE == "2" ]
        then
            echo "export CM_SID=standby"
            echo "export CM_HOME=$TB_HOME"
        elif [ $INPUT_TB_DETAIL_TYPE == "3" ]
        then
            echo "export CM_SID=observer"
            echo "export CM_HOME=$TB_HOME"
        else
            2>/dev/null
        fi
    elif [ $INPUT_TB_TYPE == "3" ]
    then
        echo "#### TAC (Tibero Active Cluster)"
        if [ $INPUT_TB_DETAIL_TYPE == "1" ]
        then
            echo "export CM_SID=cm0"
            echo "export CM_HOME=$TB_HOME"
        elif [ $INPUT_TB_DETAIL_TYPE == "2" ]
        then
            echo "export CM_SID=cm1"
            echo "export CM_HOME=$TB_HOME"
        else
            2>dev/null
        fi
    elif [ $InPUT_TB_TYPE == "4" ]PRINT_TYPE_INPUT_TYPE
    
    then
        2>/dev/null
    else
        2>/dev/null
    fi
    
    FN_USER_PROFILE_ALIAS
}

############################# TB_SID.tip
FN_TB_SID_TIP(){
    echo "############ TIBERO genernal"
    echo "#### Must"
    echo "DB_NAME=$INPUT_DB_NAME"
    echo "LISTENER_PORT=8629"
    echo "CONTROL_FILES=$INPUT_CONTROL_FILES_PATH1/tbctl1/c1.ctl, $INPUT_CONTROL_FILES_PATH1/tbctl2/c2.ctl"
    echo "DB_CREATE_FILE_DEST=$INPUT_DB_CREATE_FILE_DEST/tbdata/"
    echo "LOG_ARCHIVE_DEST=$INPUT_LOG_ARCHIVE_DEST/tbarch/"
    echo "MAX_SESSION_COUNT="
    echo "TOTAL_SHM_SIZE="
    echo "MEMORY_TARGET="

    echo "############ TFT Parameters"
    echo "#### Must"
    echo "USE_TS_QUOTA=N"
    echo "AUTHENTICATION_TIMEOUT=100"
    echo "DBLINK_CONN_TIMEOUT=100"
    echo "TPR_SNAPSHOT_RETENTION=30"
    echo "TPR_SNAPSHOT_TOP_SQL_CNT=10"
    echo "GATHER_SQL_EXEC_TIME=Y"
    echo "GATHER_SQL_PLAN_STAT=Y"
    echo "SLOG_TOTAL_SIZE_LIMIT=1G"
    echo "_SLOG_DISPLAY_YEAR=Y"
    echo "AUDIT_SYS_OPERATIONS=Y"
    echo "AUDIT_TRAIL=OS"

    echo "#### Recommand"
    echo "#BOOT_WITH_AUTO_DOWN_CLEAN=Y"
    echo "#USE_RECYCLEBIN=Y"
    echo "#LOG_DEFAULT_DEST="
    echo "#ACT_LOG_DEST="
    echo "#CALLSTACK_DUMP_DEST="
    echo "## IMS224485 - 2022.01.27"
    echo "#_STANDBY_NETWORK_TIMEOUT=90"

    if [ $INPUT_TB_TYPE == "1" ]
    then
        2>/dev/null
    elif [ $INPUT_TB_TYPE == "2" ]
    then
        echo "############ TSC (Tibero Standby Cluster)"
        echo "#### Must"
        echo "CM_PORT=28629"
        echo "STANDBY_USE_OBSERVER=Y"
        echo "LOG_REPLICATION_MODE=PERFORMANCE"
        echo "LOCAL_CLUSTER_PORT=18629"
        if [ $INPUT_TB_DETAIL_TYPE == "1" ]
        then
            echo "## Primary"
            echo "LOG_REPLICATION_DEST_1=\"<Standby IP>:8633 LGWR ASYNC\""
            echo "LOCAL_CLUSTER_ADDR=<Primary IP>"
        elif [ $INPUT_TB_DETAIL_TYPE == "2" ]
        then
            echo "## Standny"
            echo "LOG_REPLICATION_DEST_1=\"<Primary IP>:8633 LGWR ASYNC\""
            echo "LOCAL_CLUSTER_ADDR=<Standby IP>"
        elif [ $INPUT_TB_DETAIL_TYPE == "3" ]
        then
            2>/dev/null
        fi
    elif [ $INPUT_TB_TYPE == "3" ]
    then
        echo "############ TAC (Tibero Active Cluster)"
        echo "#### Must"
        echo "CLUSTER_DATABASE=Y"
        echo "_USE_O_DIRECT=Y"
        if [ $INPUT_TB_DETAIL_TYPE == "1" ]
        then
            echo "## cm0"
            echo "THREAD=0"
            echo "UNDO_TABLESPACE=UNDO0"
            echo "CM_NAME=cm0"
            echo "CM_PORT=28629"
            echo "LOCAL_CLUSTER_ADDR=<localhost IP>"
            echo "LOCAL_CLUSTER_PORT=18629"
        elif [ $INPUT_TB_DETAIL_TYPE == "2" ]
        then
            echo "## cm1"
            echo "THREAD=1"
            echo "UNDO_TABLESPACE=UNDO1"
            echo "CM_NAME=cm1"
            echo "CM_PORT=28629"
            echo "LOCAL_CLUSTER_ADDR=<localhost IP>"
            echo "LOCAL_CLUSTER_PORT=18629"
        fi
    elif [ $InPUT_TB_TYPE == "4" ]
    then 
        2>/dev/null
    fi
}

############################# CM_SID.tip
FN_CM_SID_TIP(){
    if [ $INPUT_TB_TYPE == "1" ]
    then
        2>/dev/null
    elif [ $INPUT_TB_TYPE == "2" ]
    then
        echo "############ TSC (Tibero Standby Cluster)"
        echo "#### Must"
        echo "CM_HEARTBEAT_EXPIRE=300"
        echo "CM_WATCHDOG_EXPIRE=290"
        if [ $INPUT_TB_DETAIL_TYPE == "1" ]
        then
            echo "## Primary"
            echo "CM_NAME=primary"
            echo "CM_UI_PORT=28629"
            echo "CM_RESOURCE_FILE=<TB_HOME>/config/primary_res_file"
        elif [ $INPUT_TB_DETAIL_TYPE == "2" ]
        then
            echo "## Standby"
            echo "CM_NAME=standby"
            echo "CM_UI_PORT=28629"
            echo "CM_RESOURCE_FILE=<TB_HOME>/config/standby_res_file"
        elif [ $INPUT_TB_DETAIL_TYPE == "3" ]
        then
            2>/dev/null
        fi
        echo "#### Recommand"
        echo "#CM_ENABLE_FAST_NET_ERROR_DETECTION=Y"
    elif [ $INPUT_TB_TYPE == "3" ]
    then
        echo "############ TAC (Tibero Active Cluster)"
        echo "#### Must"
        if [ $INPUT_TB_DETAIL_TYPE == "1" ]
        then
            echo "## Node1"
            echo "CM_NAME=cm0"
            echo "CM_UI_PORT=28629"
            echo "CM_RESOURCE_FILE=<TB_HOME>/config/cm0_res_file"
        elif [ $INPUT_TB_DETAIL_TYPE == "2" ]
        then
            echo "## Node2"
            echo "CM_NAME=cm1"
            echo "CM_UI_PORT=28629"
            echo "CM_RESOURCE_FILE=<TB_HOME>/config/cm1_res_file" 
        fi
        echo "### Recommand"
        echo "CM_HEARTBEAT_EXPIRE=300"
        echo "CM_WATCHDOG_EXPIRE=290"
        echo "CM_ENABLE_FAST_NET_ERROR_DETECTION=Y"
    elif [ $InPUT_TB_TYPE == "4" ]
    then 
        2>/dev/null
    fi
}

############################# CREATE_DB
FN_TB_CREATE_DB(){
   echo "CREATE DATABASE"
   echo "USER sys IDENTIFIED BY tibero"
   echo "CHARACTER SET UTF8"
   echo "LOGFILE"
   echo "GROUP 0 ('$INPUT_DB_CREATE_FILE_DEST/system/redo001.redo','$INPUT_DB_CREATE_FILE_DEST/system/redo002.redo') SIZE 300M,"
   echo "GROUP 1 ('$INPUT_DB_CREATE_FILE_DEST/system/redo011.redo','$INPUT_DB_CREATE_FILE_DEST/system/redo012.redo') SIZE 300M,"
   echo "GROUP 2 ('$INPUT_DB_CREATE_FILE_DEST/system/redo021.redo','$INPUT_DB_CREATE_FILE_DEST/system/redo022.redo') SIZE 300M,"
   echo "GROUP 3 ('$INPUT_DB_CREATE_FILE_DEST/system/redo031.redo','$INPUT_DB_CREATE_FILE_DEST/system/redo032.redo') SIZE 300M,"
   echo "GROUP 4 ('$INPUT_DB_CREATE_FILE_DEST/system/redo041.redo','$INPUT_DB_CREATE_FILE_DEST/system/redo042.redo') SIZE 300M"
   echo "MAXDATAFILES 1024"
   echo "MAXLOGFILES 100"
   echo "MAXLOGMEMBERS 8"
   echo "--MAXARCHIVELOG 500"
   echo "--MAXLOGHISTORY 500"
   echo "ARCHIVELOG"
   echo "  datafile '$INPUT_DB_CREATE_FILE_DEST/system/system001.dtf' size 2G autoextend off"
   echo "  SYSSUB"
   echo "  datafile '$INPUT_DB_CREATE_FILE_DEST/system/tpr_ts001.dtf' size 1G autoextend off"
   echo "default tablespace USR"
   echo "  datafile '$INPUT_DB_CREATE_FILE_DEST/system/usr001.dtf' size 1G autoextend off"
   echo "  extent management local UNIFORM SIZE 1M"
   echo "default temporary tablespace TEMP"
   echo "  tempfile '$INPUT_DB_CREATE_FILE_DEST/system/temp001.dtf' size 1G autoextend off"
   echo "  extent management local AUTOALLOCATE"
   echo "undo tablespace UNDO"
   echo "  datafile '%INPUT_DB_CREATE_FILE_DEST/system/undo001.dtf' size 1G autoextend off"
   echo "  extent management local UNIFORM SIZE 1M;"
}

############################# MANUAL
case $INPUT_INI_TYPE in 
USER_PROFILE)
    FN_USER_PROFILE
    ;;
TB_SID_TIP)
    FN_TB_SID_TIP
    ;;
CM_SID_TIP)
    FN_CM_SID_TIP
    ;;
AUTO_USER_PROFILE)
    AUTO_FN_USER_PROFILE
    ;;
AUTO_TB_SID_TIP)
    AUTO_FN_TB_SID_TIP
    ;;
TB_CREATE_DB)
    FN_TB_CREATE_DB
    ;;
*)
exit
;;
esac
