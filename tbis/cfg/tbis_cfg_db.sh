# Do not change

# tbdsn.tbr configuration
FN_TB_DSN(){
    echo "$TB_SID=("
    echo "  (INSTANCE=(HOST=localhost)"
    echo "  (PORT=$LISTENER_PORT)"
    echo "  (DB_NAME=$DB_NAME)"
    echo "  )"
    echo ")"
}

# Instance tip configuration
FN_TB_SID_TIP(){
    
    if [ "$TIBERO_NODE" == "observer" ]
    then
        echo
        echo "  message> tbis.cfg - TIBERO_TYPE : " $TIBERO_TYPE
        echo     
    elif [ "$INPUT_INI_TYPE" == "TB_SID_TIP" ]
    then
        echo "############ TIBERO genernal"
        echo "#### Must"
        echo "DB_NAME=$DB_NAME"
        echo "LISTENER_PORT=$LISTENER_PORT"
        echo "CONTROL_FILES=$CONTROL_FILE_PATH1/tbctl1/c1.ctl,$CONTROL_FILE_PATH2/tbctl2/c2.ctl"
        echo "DB_CREATE_FILE_DEST=$DB_CREATE_FILE_DEST/tbdata"

        if [ "$TIBERO_TYPE" == "SINGLE" ]
        then
            echo "LOG_ARCHIVE_DEST=$LOG_ARCHIVE_DEST/tbarch"
        elif [ "$TIBERO_TYPE" == "TSC" ]
        then
            echo "LOG_ARCHIVE_DEST=$LOG_ARCHIVE_DEST/tbarch"
        elif [ "$TIBERO_TYPE" == "TAC" ]
        then
            if [ "$TIBERO_NODE" == "cm0" ]
            then
                echo "LOG_ARCHIVE_DEST=$LOG_ARCHIVE_DEST/tbarch0"
            elif [ "$TIBERO_NODE" == "cm1" ]
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
        echo "#LOG_DEFAULT_DEST="
        echo "#ACT_LOG_DEST="
        echo "#CALLSTACK_DUMP_DEST="
        echo ""
        echo ""
        if [ "$TIBERO_TYPE" == "SINGLE" ]
        then
            2>/dev/null
        elif [ "$TIBERO_TYPE" == "TSC" ]
        then
            echo "############ TSC (Tibero Standby Cluster)"
            echo "#### Must"
            echo "CM_PORT=$CM_PORT"
            if [ "$TIBERO_OBSERVER_ENABLE" == "Y" ]
            then
                echo "STANDBY_USE_OBSERVER=Y"
            elif [ "$TIBERO_OBSERVER_ENABLE" == "N" ]
            then
                echo "STANDBY_USE_OBSERVER=N"
            fi
            echo "LOG_REPLICATION_MODE=PERFORMANCE"
            echo "LOCAL_CLUSTER_PORT=$LOCAL_CLUSTER_PORT"
            echo ""
            if [ "$TIBERO_NODE" == "primary" ]
            then
                echo "## Primary"
                echo "LOG_REPLICATION_DEST_1=\"$NODE2_INTER_IP:8633 LGWR ASYNC\""
                echo "LOCAL_CLUSTER_ADDR=$NODE1_INTER_IP"
                echo ""
                echo "#### Recommand"
            elif [ "$TIBERO_NODE" == "standby" ]
            then
                echo "## standby"
                echo "LOG_REPLICATION_DEST_1=\"$NODE1_INTER_IP:8633 LGWR ASYNC\""
                echo "LOCAL_CLUSTER_ADDR=$NODE2_INTER_IP"
                echo ""
                echo "#### Recommand"
            elif [ "$TIBERO_NODE" == "observer" ]
            then
                2>/dev/null
            fi
        elif [ "$TIBERO_TYPE" == "TAC" ]
        then
            echo "############ TAC (Tibero Active Cluster)"
            echo "#### Must"
            echo "CLUSTER_DATABASE=Y"
            echo "_USE_O_DIRECT=Y"
            echo ""
            if [ "$TIBERO_NODE" == "cm0" ]
            then
                echo "## cm0"
                echo "THREAD=0"
                echo "UNDO_TABLESPACE=UNDO0"
                echo "#CM_NAME=cm0"
                echo "CM_PORT=$CM_PORT"
                echo "LOCAL_CLUSTER_ADDR=$NODE1_INTER_IP"
                echo "LOCAL_CLUSTER_PORT=$LOCAL_CLUSTER_PORT"
            elif [ "$TIBERO_NODE" == "cm1" ]
            then
                echo "## cm1"
                echo "THREAD=1"
                echo "UNDO_TABLESPACE=UNDO1"
                echo "#CM_NAME=cm1"
                echo "CM_PORT=$CM_PORT"
                echo "LOCAL_CLUSTER_ADDR=$NODE2_INTER_IP"
                echo "LOCAL_CLUSTER_PORT=$LOCAL_CLUSTER_PORT"
            fi
            echo ""
            echo ""
        fi       
    fi
}