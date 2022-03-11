#!/bin/sh
############################################################
#
# user configuration
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
TIBERO_NODE=cm0
#TIBERO_NODE=cm1
# 
# TIBERO ENV
TB_SID=tibero0
DB_NAME=tibero
TB_HOME=/tibero/tibero6
#
#
CONTROL_FILES1=/tibero/tbdata
CONTROL_FILES2=/tibero/tbdata
DB_CREATE_FILE_DEST=/tibero/tbdata
LOG_ARCHIVE_DEST=/tibero/tbdata
#
#
NODE1_INTER_IP=192.168.41.220
#NODE2_INTER_IP=192.168.111.12
#
# TSC 일 경우 다르면 ERROR
#NODE1_VIP_IP=192.168.111.13
#NODE2_VIP_IP=192.168.111.13

IFNAME1=enp0s8
#IFNAME2=


############################################################
#
# Program variables
############################################################
# Initialization
#INPUT_INI_TYPE=$1

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

    elif [ $TIBERO_TYPE == "TAS" ]
    then
        2>/dev/null
    else
        2>/dev/null
    fi
    echo ""
    echo ""
        echo "### Genernal"
        echo "export TB_PROF_DIR=\$TB_HOME/bin/prof"
        echo "export LD_LIBRARY_PATH=\$TB_HOME/lib:$TB_HOME/client/lib"
        echo "export LIBPATH=\$LD_LIBRARY_PATH"
        echo "export SHLIB_PATH=\$LD_LIBRARY_PATH"
        echo "export PATH=\$PATH:\$TB_HOME/bin:\$TB_HOME/client/bin:\$JAVA_HOME/bin"
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
    echo "## IMS224485 - 2022.01.27"
    echo "#_STANDBY_NETWORK_TIMEOUT=90"
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
    elif [ $TIBERO_TYPE == "4" ]
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

############################# DATABASE CREATE
FN_CRE_DATABASE(){
echo "CREATE DATABASE"
echo "USER sys IDENTIFIED BY tibero"
echo "CHARACTER SET UTF8"
echo "LOGFILE"
echo "GROUP 0 ('$DB_CREATE_FILE_DEST/system/redo001.redo','$DB_CREATE_FILE_DEST/system/redo002.redo') SIZE 100M,"
echo "GROUP 1 ('$DB_CREATE_FILE_DEST/system/redo011.redo','$DB_CREATE_FILE_DEST/system/redo012.redo') SIZE 100M,"
echo "GROUP 2 ('$DB_CREATE_FILE_DEST/system/redo021.redo','$DB_CREATE_FILE_DEST/system/redo022.redo') SIZE 100M,"
echo "GROUP 3 ('$DB_CREATE_FILE_DEST/system/redo031.redo','$DB_CREATE_FILE_DEST/system/redo032.redo') SIZE 100M,"
echo "GROUP 4 ('$DB_CREATE_FILE_DEST/system/redo041.redo','$DB_CREATE_FILE_DEST/system/redo042.redo') SIZE 100M"
echo "MAXDATAFILES 1024"
echo "MAXLOGFILES 100"
echo "MAXLOGMEMBERS 8 "
echo "--MAXARCHIVELOG 500"
echo "--MAXLOGHISTORY 500"
echo "ARCHIVELOG"
echo "  datafile '$DB_CREATE_FILE_DEST/system/system001.dtf' size 100M autoextend off"
echo "  SYSSUB"
echo "  datafile '$DB_CREATE_FILE_DEST/system/tpr_ts001.dtf' size 100M autoextend off"
echo "default tablespace USR"
echo "  datafile '$DB_CREATE_FILE_DEST/system/usr001.dtf' size 100M autoextend off"
echo "  extent management local UNIFORM SIZE 1M"
echo "default temporary tablespace TEMP"
echo "  tempfile '$DB_CREATE_FILE_DEST/system/temp001.dtf' size 100M autoextend off"
echo "  extent management local AUTOALLOCATE"
echo "undo tablespace UNDO0"
echo "  datafile '$DB_CREATE_FILE_DEST/system/undo001.dtf' size 100M autoextend off"
echo "  extent management local UNIFORM SIZE 1M"
echo ";"
}
FN_ADD_CRE_DATABASE(){
echo "create undo tablespace UNDO1 datafile '$DB_CREATE_FILE_DEST/system/undo002.dtf' size 1G autoextend off;"
echo "alter database add logfile thread 1 group 5 ('$DB_CREATE_FILE_DEST/system/redo051.redo','$DB_CREATE_FILE_DEST/system/redo052.redo') SIZE 100M;"
echo "alter database add logfile thread 1 group 6 ('$DB_CREATE_FILE_DEST/system/redo061.redo','$DB_CREATE_FILE_DEST/system/redo062.redo') SIZE 100M;"
echo "alter database add logfile thread 1 group 7 ('$DB_CREATE_FILE_DEST/system/redo071.redo','$DB_CREATE_FILE_DEST/system/redo072.redo') SIZE 100M;"
echo "alter database add logfile thread 1 group 8 ('$DB_CREATE_FILE_DEST/system/redo081.redo','$DB_CREATE_FILE_DEST/system/redo082.redo') SIZE 100M;"
echo "alter database add logfile thread 1 group 9 ('$DB_CREATE_FILE_DEST/system/redo091.redo','$DB_CREATE_FILE_DEST/system/redo092.redo') SIZE 100M;"
echo "alter database enable public thread 1;"
}



############################# CM 
FN_CM_RESOURCE(){
    if [ $TIBERO_TYPE == "SINGLE" ]
    then
        2>/dev/null
    elif [ $TIBERO_TYPE == "TSC" ]
    then
        2>/dev/null
    elif [ $TIBERO_TYPE == "TAC" ]
    then
        if [ $TIBERO_NODE == "cm0" ]
        then
            echo "cmrctl add network --name net0 --ipaddr $NODE1_INTER_IP --portno 29000"
            echo "cmrctl add network --name pub0 --nettype public --ifname $IFNAME1"
            echo "cmrctl add cluster --name cls0 --incnet net0 --pubnet pub0 --cfile $DB_CREATE_FILE_DEST/CM/CMFILE"
            echo "cmrctl start cluster --name cls0"
            echo "cmrctl add service --name $DB_NAME --cname cls0 --type db"
            echo "cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME"
            #echo "cmrctl add vip --name < vip0 > --svcname <DB_NAME> --ipaddr <vip_ip>/<vip_ip 3octet>.255 --bcast <broadcast>"
        elif [ $TIBERO_NODE == "cm1" ]
        then
            echo "cmrctl add network --name net1 --ipaddr $NODE2_INTER_IP --portno 29000"
            echo "cmrctl add network --name pub1 --nettype public --ifname $IFNAME1"
            echo "cmrctl add cluster --name cls0 --incnet net1 --pubnet pub1 --cfile $DB_CREATE_FILE_DEST/CM/CMFILE"
            echo "cmrctl start cluster --name cls0"
            echo "cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME"
            #echo "cmrctl add vip --name < vip1 > --svcname <DB_NAME> --ipaddr <vip_ip>/<vip_ip 3octet>.255 --bcast <broadcast>"
            fi
    fi
    
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
CRE_DATABASE)
    FN_CRE_DATABASE
    ;;
CM_RESOURCE)
    FN_CM_RESOURCE
    ;;
ADD_CRE_DATABASE)
    FN_ADD_CRE_DATABASE
    ;;
*)
exit
;;
esac