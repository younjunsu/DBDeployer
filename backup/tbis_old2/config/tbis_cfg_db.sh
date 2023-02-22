# Do not change

# instance tip configuration
fun_db_tip(){
        echo "############ TIBERO genernal"
        echo "#### Must"
        echo "DB_NAME=$DB_NAME"
        echo "LISTENER_PORT=$LISTENER_PORT"
        echo "CONTROL_FILES=$CONTROL_FILE_PATH1/tbctl1/c1.ctl,$CONTROL_FILE_PATH2/tbctl2/c2.ctl"
        echo "DB_CREATE_FILE_DEST=$DB_CREATE_FILE_DEST/tbdata"

        if [ "$tibero_type" == "SINGLE" ]
        then
            echo "LOG_ARCHIVE_DEST=$LOG_ARCHIVE_DEST/tbarch"
        elif [ "$tibero_type" == "TSC" ]
        then
            echo "LOG_ARCHIVE_DEST=$LOG_ARCHIVE_DEST/tbarch"
        elif [ "$tibero_type" == "TAC" ]
        then
            if [ "$tibero_node" == "cm0" ]
            then
                echo "LOG_ARCHIVE_DEST=$LOG_ARCHIVE_DEST/tbarch0"
            elif [ "$tibero_node" == "cm1" ]
            then
                echo "LOG_ARCHIVE_DEST=$LOG_ARCHIVE_DEST/tbarch1"
            fi
        fi

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
        echo "#ACT_LOG_DEST="
        echo "#LOG_DEFAULT_DEST="        
        echo "#CALLSTACK_DUMP_DEST="
        echo ""
        echo ""
        if [ "$tibero_type" == "TSC" ]
        then
            echo "############ TSC (Tibero Standby Cluster)"
            echo "#### Must"
            echo "CM_PORT=$CM_PORT"
            if [ "$tibero_observer_enable" == "Y" ]
            then
                echo "STANDBY_USE_OBSERVER=Y"
            elif [ "$tibero_observer_enable" == "N" ]
            then
                echo "STANDBY_USE_OBSERVER=N"
            fi
            echo "LOG_REPLICATION_MODE=PERFORMANCE"
            echo "LOCAL_CLUSTER_PORT=$LOCAL_CLUSTER_PORT"
            echo ""
            if [ "$tibero_node" == "primary" ]
            then
                echo "## Primary"
                echo "LOG_REPLICATION_DEST_1=\"$node2_interconnect_ip:8633 LGWR ASYNC\""
                echo "LOCAL_CLUSTER_ADDR=$node1_interconnect_ip"
                echo ""
                echo "#### Recommand"
            elif [ "$tibero_node" == "standby" ]
            then
                echo "## standby"
                echo "LOG_REPLICATION_DEST_1=\"$node1_interconnect_ip:8633 LGWR ASYNC\""
                echo "LOCAL_CLUSTER_ADDR=$node2_interconnect_ip"
                echo ""
                echo "#### Recommand"
            fi
        elif [ "$tibero_type" == "TAC" ]
        then
            echo "############ TAC (Tibero Active Cluster)"
            echo "#### Must"
            echo "CLUSTER_DATABASE=Y"
            echo "_USE_O_DIRECT=Y"
            echo ""
            if [ "$tibero_node" == "cm0" ]
            then
                echo "## cm0"
                echo "THREAD=0"
                echo "UNDO_TABLESPACE=UNDO0"
                echo "#CM_NAME=cm0"
                echo "CM_PORT=$CM_PORT"
                echo "LOCAL_CLUSTER_ADDR=$node1_interconnect_ip"
                echo "LOCAL_CLUSTER_PORT=$LOCAL_CLUSTER_PORT"
            elif [ "$tibero_node" == "cm1" ]
            then
                echo "## cm1"
                echo "THREAD=1"
                echo "UNDO_TABLESPACE=UNDO1"
                echo "#CM_NAME=cm1"
                echo "CM_PORT=$CM_PORT"
                echo "LOCAL_CLUSTER_ADDR=$node2_interconnect_ip"
                echo "LOCAL_CLUSTER_PORT=$LOCAL_CLUSTER_PORT"
            fi
            echo ""
            echo ""
        fi
}

# profile mode check
# apply: create profile file
# output: display output
cfg_db_mode=$1

if [ -z $"cfg_db_mode" ]
then
    2>/dev/null
elif [ "$cfg_db_mode" == "apply" ]
then
    echo
    echo "############################################################"
    echo "# tbis Progress> TB_SID TIP File"
    echo "############################################################"
    echo
    echo " - $TB_SID.tip $TB_HOME/config/$TB_SID.tip apply configuration"
    echo
    . $tbis_current_path/function/tbis_fun_common.sh progress_chk
    
    if [ "$progress_yesno" == "YES" ]
    then
        fun_db_tip >> "$TB_HOME"/config/"$TB_SID".tip
    fi
elif [ "$cfg_db_mode" == "output" ]
then
    fun_db_tip
fi
