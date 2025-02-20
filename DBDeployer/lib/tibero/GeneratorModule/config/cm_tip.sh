function fn_cm_tip(){
    if [ "$tibero_type" == "TSC" ]
    then
        echo "############ TSC (Tibero Standby Cluster)"
        echo "#### must"
        echo "CM_HEARTBEAT_EXPIRE=300"
        echo "CM_WATCHDOG_EXPIRE=290"
        echo ""
        if [ "$tibero_node" == "primary" ]
        then
            echo "## primary"
            echo "CM_NAME=primary"
            echo "CM_UI_PORT=$CM_UI_PORT"
            echo "CM_RESOURCE_FILE=$TB_HOME/config/primary_res_file"
            echo ""
        elif [ "$tibero_node" == "standby" ]
        then
            echo "## standby"
            echo "CM_NAME=standby"
            echo "CM_UI_PORT=$CM_UI_PORT"
            echo "CM_RESOURCE_FILE=$TB_HOME/config/standby_res_file"
            echo ""
        elif [ "$tibero_node" == "observer" ]
        then
            echo "## observer"
            echo "CM_NAME=observer"
            echo "CM_UI_PORT=$OBS_CM_UI_PORT"
            echo "CM_OBSERVER_PORT=$CM_OBSERVER_PORT"
            echo "CM_MODE_OBSERVER=Y"
        fi
        echo "#### recommand"
        echo "#CM_ENABLE_FAST_NET_ERROR_DETECTION=Y"
        echo ""
    elif [ "$tibero_type" == "TAC" ]
    then
        echo "############ TAC (Tibero Active Cluster)"
        echo "#### must"
        echo ""
        if [ "$tibero_node" == "cm0" ]
        then
            echo "## node1"
            echo "CM_NAME=cm0"
            echo "CM_UI_PORT=28629"
            echo "CM_RESOURCE_FILE=$TB_HOME/config/cm0_res_file"
            echo ""
        elif [ "$tibero_node" == "cm1" ]
        then
            echo "## node2"
            echo "CM_NAME=cm1"
            echo "CM_UI_PORT=28629"
            echo "CM_RESOURCE_FILE=$TB_HOME/config/cm1_res_file" 
            echo ""
        fi
        echo "### recommand"
        echo "CM_HEARTBEAT_EXPIRE=300"
        echo "CM_WATCHDOG_EXPIRE=290"
        echo "CM_ENABLE_FAST_NET_ERROR_DETECTION=Y"
        echo ""
    elif [ "$tibero_type" == "SINGLE" ]
    then
        echo
        echo "  message> tbis.cfg - tibero_type : " $tibero_type
        echo
    fi
}
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
fn_cm_tip
#--------------------------------------------------------------------------------
