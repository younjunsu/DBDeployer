# Do not change


# cm tip configuration
FN_CM_SID_TIP(){
    if [ "$TIBERO_TYPE" == "TSC" ]
    then
        echo "############ TSC (Tibero Standby Cluster)"
        echo "#### Must"
        echo "CM_HEARTBEAT_EXPIRE=300"
        echo "CM_WATCHDOG_EXPIRE=290"
        echo ""
        if [ "$TIBERO_NODE" == "primary" ]
        then
            echo "## Primary"
            echo "CM_NAME=primary"
            echo "CM_UI_PORT=$CM_UI_PORT"
            echo "CM_RESOURCE_FILE=$TB_HOME/config/primary_res_file"
            echo ""
        elif [ "$TIBERO_NODE" == "standby" ]
        then
            echo "## Standby"
            echo "CM_NAME=standby"
            echo "CM_UI_PORT=$CM_UI_PORT"
            echo "CM_RESOURCE_FILE=$TB_HOME/config/standby_res_file"
            echo ""
        elif [ "$TIBERO_NODE" == "observer" ]
        then
            echo "## Observer"
            echo "CM_NAME=observer"
            echo "CM_UI_PORT=$OBS_CM_UI_PORT"
            echo "CM_OBSERVER_PORT=$CM_OBSERVER_PORT"
            echo "CM_MODE_OBSERVER=Y"
        fi
        echo "#### Recommand"
        echo "#CM_ENABLE_FAST_NET_ERROR_DETECTION=Y"
        echo ""
    elif [ "$TIBERO_TYPE" == "TAC" ]
    then
        echo "############ TAC (Tibero Active Cluster)"
        echo "#### Must"
        echo ""
        if [ "$TIBERO_NODE" == "cm0" ]
        then
            echo "## Node1"
            echo "CM_NAME=cm0"
            echo "CM_UI_PORT=28629"
            echo "CM_RESOURCE_FILE=$TB_HOME/config/cm0_res_file"
            echo ""
        elif [ "$TIBERO_NODE" == "cm1" ]
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
    elif [ "$TIBERO_TYPE" == "SINGLE" ]
    then
        echo
        echo "  message> tbis.cfg - TIBERO_TYPE : " $TIBERO_TYPE
        echo
    fi
}

# CM resource configuration
FN_CM_RESOURCE(){
    TIBERO_BASHPROFILE=$USER_HOME/.bash_profile
    TIBERO_PROFILE=$USER_HOME/.profile

    if [ -f "$TIBERO_PROFILE" ]
    then
        TIBERO_PROFILE_CHECK=$TIBERO_PROFILE
    elif [ -f "$TIBERO_BASHPROFILE" ]
    then
        TIBERO_PROFILE_CHECK=$TIBERO_BASHPROFILE
    fi

    if [ "$TIBERO_TYPE" == "TSC" ]
    then
        if [ "$TIBERO_NODE" == "primary" ]
        then
            echo "cmrctl add network --name net0 --ipaddr $NODE1_INTER_IP --portno $TBCM_NET_PORT"
            if [ -z "$NODE1_VIP_ETH" ]
            then
                    echo "cmrctl add cluster --name cls0 --incnet net0 --cfile $CFILE_PATH/CMFILE_cls0"
                    echo "cmrctl start cluster --name cls0"            
                    if [ "$TIBERO_OBSERVER_ENABLE" == "Y" ] 
                    then
                        echo "cmrctl add service --name $DB_NAME --cname cls0 --tscid 11 --obsip $NODE_OBSERVER_IP --obsport $CM_OBSERVER_PORT"
                    elif [ "$TIBERO_OBSERVER_ENABLE" == "N" ] || [ -z "$TIBERO_OBSERVER_ENABLE" ]
                    then
                        echo "cmrctl add service --name $DB_NAME --cname cls0 --tscid 11"
                    fi                    
                    echo "cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME --envfile $TIBERO_PROFILE_CHECK"
                else
                    echo "cmrctl add network --name pub0 --nettype public --ifname $NODE1_VIP_ETH"
                    echo "cmrctl add cluster --name cls0 --incnet net0 --pubnet pub0 --cfile $CFILE_PATH/CMFILE_cls0"
                    echo "cmrctl start cluster --name cls0"
                    if [ "$TIBERO_OBSERVER_ENABLE" == "Y" ] 
                    then
                        echo "cmrctl add service --name $DB_NAME --cname cls0 --tscid 11 --obsip $NODE_OBSERVER_IP --obsport $CM_OBSERVER_PORT"
                    elif [ "$TIBERO_OBSERVER_ENABLE" == "N" ] || [ -z "$TIBERO_OBSERVER_ENABLE" ]
                    then
                        echo "cmrctl add service --name $DB_NAME --cname cls0 --tscid 11"
                    fi                    
                    echo "cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME --envfile $TIBERO_PROFILE_CHECK"
                    echo "cmrctl add vip --name vip0 --svcname $DB_NAME --ipaddr $NODE1_VIP_IP"
            fi
        elif [ "$TIBERO_NODE" == "standby" ]
        then
           echo "cmrctl add network --name net1 --ipaddr $NODE2_INTER_IP --portno $TBCM_NET_PORT"
                if [ -z "$NODE2_VIP_ETH" ]
                then
                    echo "cmrctl add cluster --name cls1 --incnet net1 --cfile $CFILE_PATH/CMFILE_cls1"
                    echo "cmrctl start cluster --name cls1"
                    if [ "$TIBERO_OBSERVER_ENABLE" == "Y" ] 
                    then
                        echo "cmrctl add service --name $DB_NAME --cname cls1 --tscid 11 --obsip $NODE_OBSERVER_IP --obsport $CM_OBSERVER_PORT"
                    elif [ "$TIBERO_OBSERVER_ENABLE" == "N" ] || [ -z "$TIBERO_OBSERVER_ENABLE" ]
                    then
                        echo "cmrctl add service --name $DB_NAME --cname cls1 --tscid 11"
                    fi
                    echo "cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME --envfile $TIBERO_PROFILE_CHECK"
                else
                    echo "cmrctl add network --name pub1 --nettype public --ifname $NODE2_VIP_ETH"
                    echo "cmrctl add cluster --name cls1 --incnet net1 --pubnet pub1 --cfile $CFILE_PATH/CMFILE_cls1"
                    echo "cmrctl start cluster --name cls1"
                    if [ "$TIBERO_OBSERVER_ENABLE" == "Y" ] 
                    then
                        echo "cmrctl add service --name $DB_NAME --cname cls1 --tscid 11 --obsip $NODE_OBSERVER_IP --obsport $CM_OBSERVER_PORT"
                    elif [ "$TIBERO_OBSERVER_ENABLE" == "N" ] || [ -z "$TIBERO_OBSERVER_ENABLE" ]
                    then
                        echo "cmrctl add service --name $DB_NAME --cname cls1 --tscid 11"
                    fi
                    echo "cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME --envfile $TIBERO_PROFILE_CHECK"
                    echo "cmrctl add vip --name vip1 --svcname $DB_NAME --ipaddr $NODE2_VIP_IP"
                fi
        elif [ "$TIBERO_NODE" == "observer" ]
        then
            2>/dev/null
        fi
    elif [ "$TIBERO_TYPE" == "TAC" ]
    then
       2>/dev/null
        if [ "$TIBERO_NODE" == "cm0" ]
        then
            echo "cmrctl add network --name net0 --ipaddr $NODE1_INTER_IP --portno $TBCM_NET_PORT"
            if [ -z "$NODE1_VIP_ETH" ]
            then
                echo "cmrctl add cluster --name cls0 --incnet net0 --cfile $CFILE_PATH/CMFILE"
                echo "cmrctl start cluster --name cls0"
                echo "cmrctl add service --name $DB_NAME --cname cls0 --type db"
                echo "cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME"
            else
                echo "cmrctl add network --name pub0 --nettype public --ifname $NODE1_VIP_ETH"
                echo "cmrctl add cluster --name cls0 --incnet net0 --pubnet pub0 --cfile $CFILE_PATH/CMFILE"
                echo "cmrctl start cluster --name cls0"
                echo "cmrctl add service --name $DB_NAME --cname cls0 --type db"
                echo "cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME"
                echo "cmrctl add vip --name vip0 --svcname $DB_NAME --ipaddr $NODE1_VIP_IP"
            fi
        elif [ "$TIBERO_NODE" == "cm1" ]
        then
            echo "cmrctl add network --name net1 --ipaddr $NODE2_INTER_IP --portno $TBCM_NET_PORT"
            if [ -z "$NODE2_VIP_ETH" ]
            then
                echo "cmrctl add cluster --name cls0 --incnet net1  --cfile $CFILE_PATH/CMFILE"
                echo "cmrctl start cluster --name cls0"
                echo "cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME"
            else
                echo "cmrctl add network --name pub1 --nettype public --ifname $NODE2_VIP_ETH"
                echo "cmrctl add cluster --name cls0 --incnet net1 --pubnet pub1 --cfile $CFILE_PATH/CMFILE"
                echo "cmrctl start cluster --name cls0"
                echo "cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME"
                echo "cmrctl add vip --name vip1 --svcname $DB_NAME --ipaddr $NODE2_VIP_IP"
            fi
        fi
    elif [ "$TIBERO_TYPE" == "SINGLE" ]
    then
        echo
        echo "  message> tbis.cfg - TIBERO_TYPE : " $TIBERO_TYPE
        echo
    elif [ "$TIBERO_TYPE" == "observer" ]
    then
        echo
        echo "  message> tbis.cfg - TIBERO_TYPE : " $TIBERO_TYPE
        echo
    fi    
}