#!/bin/sh
############################################################
#
# usr configuration
############################################################
#
# TIBERO TYPE
#TIBERO_TYPE=SINGLE
#TIBERO_TYPE=TSC
TIBERO_TYPE=TAC
#
# TIBERO NODE
#TIBERO_NODE=SINGLE
#TIBERO_NODE=primary
#TIBERO_NODE=standby
#TIBERO_NODE=observer
#TIBERO_NODE=cm0
#TIBERO_NODE=cm1
# 
# TIBERO ENV
TB_SID=tibero
DB_NAME=tibero
TB_HOME=/home/tibero/tibero6
#
#
CONTROL_FILES1=/data
CONTROL_FILES2=/tibero
DB_CREATE_FILE_DEST=/data
LOG_ARCHIVE_DEST=/data
#
#
NODE1_INTER_IP=192.168.111.11
NODE2_INTER_IP=192.168.111.12
#
# TSC 일 경우 다르면 ERROR
NODE1_VIP_IP=192.168.111.13
NODE2_VIP_IP=192.168.111.13

############################################################
#
# Check User configuration
############################################################
if [ $TIBERO_TYPE == "SINGLE" ]
then
    if [ $TIBERO_NODE != "SINGLE" ] || [ $TIBERO_NODE -z ]
    then
        echo "DO NOT MATCH"
        echo $TIBERO_NODE
        exit 1
    fi
    echo ""
elif [ $TIBERO_TYPE == "TSC" ]
then
    if  [ $TIBERO_NODE -z ]
    then
        echo "TIBERO_NODE DO NOT MATCH"
        exit
    fi

    if [ $TIBERO_NODE != "primary" ] && [ $TIBERO_NODE != "standby" ] && [ $TIBERO_NODE != "observer" ]
    then
        echo "# "$TIBERO_TYPE
        echo "# TIBERO_NODE"
        echo "# - primary"
        echo "# - standby"
        echo "# - observer"
        echo ""
        echo "TIBERO_NODE DO NOT MATCH"
        echo $TIBERO_NODE
        exit 1
    fi
    echo ""
elif [ $TIBERO_TYPE == "TAC" ]
then
    if  [ $TIBERO_NODE -z ]
    then
        echo "TIBERO_NODE DO NOT MATCH"
        exit
    fi
    
    if [ $TIBERO_NODE != "cm0" ] && [ $TIBERO_NODE != "cm1" ]    
    then
        echo "DO NOT MATCH"
        echo $TIBERO_NODE
        exit 1
    fi
    echo ""
fi

############################################################
#
# Program variables
############################################################
# Initialization
INPUT_INI_TYPE=TB_SID_TIP

# Functions Parameters

############################# Profile
# automatic - DO NOT CHANGE !!!
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
    echo "#### SHELL"
    echo "stty erase ^H"
    echo "export PS1="[\`whoami\`@\`hostname\`:\$PWD]\$ ""
    echo "export EDITOR=vim"
    echo ""
    echo "#### JAVA"
    echo "#export JAVA_HOME="
    echo ""
    if [ $TIBERO_TYPE == "SINGLE" ]
    then
        echo "#### SINGLE"
        echo "export TB_SID=`echo $DB_NAME`"
        echo "export TB_HOME=$TB_HOME"
    elif [ $TIBERO_TYPE == "TSC" ]
    then
        echo "#### TSC (Tibero Standby Cluster)"
        if [ $TIBERO_NODE == "primary" ]
        then
            echo "export TB_SID=`echo $DB_NAME`_p"
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=primary"
            echo "export CM_HOME=\$TB_HOME"
        elif [ $TIBERO_NODE == "standby" ]
        then
            echo "export TB_SID=`echo $DB_NAME`_s"
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=standby"
            echo "export CM_HOME=\$TB_HOME"
        elif [ $TIBERO_NODE == "observer" ]
        then
            echo "export CM_SID=observer"
            echo "export CM_HOME=\$TB_HOME"
        else
            2>/dev/null
        fi
    elif [ $TIBERO_TYPE == "TAC" ]
    then
        echo "#### TAC (Tibero Active Cluster)"
        if [ $TIBERO_NODE == "cm0" ]
        then
            echo "export TB_SID=`echo $DB_NAME`0"
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=cm0"
            echo "export CM_HOME=\$TB_HOME"
        elif [ $TIBERO_NODE == "cm1" ]
        then
            echo "export TB_SID=`echo $DB_NAME`1"
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=cm1"
            echo "export CM_HOME=\$TB_HOME"
        else
            2>dev/null
        fi
        echo "### Genernal"
        echo "export TB_PROF_DIR=\$TB_HOME/bin/prof"
        echo "export LD_LIBRARY_PATH=\$TB_HOME/lib:$TB_HOME/client/lib"
        echo "export LIBPATH=\$LD_LIBRARY_PATH"
        echo "export SHLIB_PATH=\$LD_LIBRARY_PATH"
        echo "export PATH\$PATH:\$TB_HOME/bin:\$TB_HOME/client/bin:\$JAVA_HOME/bin"
        echo ""
    elif [ $TIBERO_TYPE == "TAS" ]
    then
        2>/dev/null
    else
        2>/dev/null
    fi
    echo ""
    echo ""
    FN_USER_PROFILE_ALIAS
}

############################# TB_SID.tip
FN_TB_SID_TIP(){
    echo "############ TIBERO genernal"
    echo "#### Must"
    echo "DB_NAME=$DB_NAME"
    echo "LISTENER_PORT=8629"
    echo "CONTROL_FILES=$CONTROL_FILES1/tbctl1/c1.ctl,$CONTROL_FILES2/tbctl2/c2.ctl"
    echo "DB_CREATE_FILE_DEST=$DB_CREATE_FILE_DEST/tbdata"
    echo "LOG_ARCHIVE_DEST=$LOG_ARCHIVE_DEST/tbarch"
    echo "MAX_SESSION_COUNT=100"
    echo "TOTAL_SHM_SIZE=2G"
    echo "MEMORY_TARGET=4G"
    echo ""
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
    echo ""
    echo "#### Recommand"
    echo "#BOOT_WITH_AUTO_DOWN_CLEAN=Y"
    echo "#USE_RECYCLEBIN=Y"
    echo "#LOG_DEFAULT_DEST="
    echo "#ACT_LOG_DEST="
    echo "#CALLSTACK_DUMP_DEST="
    echo ""
    echo ""
    if [ $TIBERO_TYPE == "SINGLE" ]
    then
        2>/dev/null
    elif [ $TIBERO_TYPE == "TSC" ]
    then
        echo "############ TSC (Tibero Standby Cluster)"
        echo "#### Must"
        echo "CM_PORT=28629"
        echo "STANDBY_USE_OBSERVER=Y"
        echo "LOG_REPLICATION_MODE=PERFORMANCE"
        echo "LOCAL_CLUSTER_PORT=18629"
        echo ""
        if [ $TIBERO_NODE == "primary" ]
        then
            echo "## Primary"
            echo "LOG_REPLICATION_DEST_1=\"$NODE2_INTER_IP:8633 LGWR ASYNC\""
            echo "LOCAL_CLUSTER_ADDR=$NODE1_INTER_IP"
        elif [ $TIBERO_NODE == "standby" ]
        then
            echo "## standby"
            echo "LOG_REPLICATION_DEST_1=\"$NODE1_INTER_IP:8633 LGWR ASYNC\""
            echo "LOCAL_CLUSTER_ADDR=$NODE2_INTER_IP"
        elif [ $TIBERO_NODE == "observer" ]
        then
            2>/dev/null
        fi
    elif [ $TIBERO_TYPE == "TAC" ]
    then
        echo "############ TAC (Tibero Active Cluster)"
        echo "#### Must"
        echo "CLUSTER_DATABASE=Y"
        echo "_USE_O_DIRECT=Y"
        echo ""
        if [ $TIBERO_NODE == "cm0" ]
        then
            echo "## cm0"
            echo "THREAD=0"
            echo "UNDO_TABLESPACE=UNDO0"
            echo "CM_NAME=cm0"
            echo "CM_PORT=28629"
            echo "LOCAL_CLUSTER_ADDR=$NODE1_INTER_IP"
            echo "LOCAL_CLUSTER_PORT=18629"
        elif [ $TIBERO_NODE == "cm1" ]
        then
            echo "## cm1"
            echo "THREAD=1"
            echo "UNDO_TABLESPACE=UNDO1"
            echo "CM_NAME=cm1"
            echo "CM_PORT=28629"
            echo "LOCAL_CLUSTER_ADDR=$NODE2_INTER_IP"
            echo "LOCAL_CLUSTER_PORT=18629"
        fi
        echo ""
        echo ""
    elif [ $TIBERO_TYPE == "TAS" ]
    then 
        2>/dev/null
    fi
}

############################# CM_SID.tip
FN_CM_SID_TIP(){
    if [ $TIBERO_TYPE == "SINGLE" ]
    then
        2>/dev/null
    elif [ $TIBERO_TYPE == "TSC" ]
    then
        echo "############ TSC (Tibero Standby Cluster)"
        echo "#### Must"
        echo "CM_HEARTBEAT_EXPIRE=300"
        echo "CM_WATCHDOG_EXPIRE=290"
        echo ""
        if [ $TIBERO_NODE == "primary" ]
        then
            echo "## Primary"
            echo "CM_NAME=primary"
            echo "CM_UI_PORT=28629"
            echo "CM_RESOURCE_FILE=$TB_HOME/config/primary_res_file"
            echo ""
        elif [ $TIBERO_NODE == "standby" ]
        then
            echo "## Standby"
            echo "CM_NAME=standby"
            echo "CM_UI_PORT=28629"
            echo "CM_RESOURCE_FILE=$TB_HOME/config/standby_res_file"
            echo ""
        elif [ $TIBERO_NODE == "observer" ]
        then
            2>/dev/null
        fi
        echo "#### Recommand"
        echo "#CM_ENABLE_FAST_NET_ERROR_DETECTION=Y"
        echo ""
    elif [ $TIBERO_TYPE == "TAC" ]
    then
        echo "############ TAC (Tibero Active Cluster)"
        echo "#### Must"
        echo ""
        if [ $TIBERO_NODE == "cm0" ]
        then
            echo "## Node1"
            echo "CM_NAME=cm0"
            echo "CM_UI_PORT=28629"
            echo "CM_RESOURCE_FILE=$TB_HOME/config/cm0_res_file"
            echo ""
        elif [ $TIBERO_NODE == "cm1" ]
        then
            echo "## Node2"
            echo "CM_NAME=cm1"
            echo "CM_UI_PORT=28629"
            echo "CM_RESOURCE_FILE=$TB_HOME/config/cm1_res_file" 
            echo ""
        fi
        echo "### Recommand"
        echo "CM_HEARTBEAT_EXPIRE=300"
        echo "CM_WATCHDOG_EXPIRE=290"
        echo "CM_ENABLE_FAST_NET_ERROR_DETECTION=Y"
        echo ""
    elif [ $TIBERO_TYPE == "TAS" ]
    then 
        2>/dev/null
    fi
}

############################# 
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
*)
exit
;;
esac

