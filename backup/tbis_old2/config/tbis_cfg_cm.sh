# Do not change

# cm tip configuration
fun_cm_tip(){
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

# CM resource configuration
fun_cm_resource(){
    if [ "$tibero_type" == "TSC" ]
    then
        if [ "$tibero_node" == "primary" ]
        then
            echo "cmrctl add network --name net0 --ipaddr $NODE1_INTER_IP --portno $TBCM_NET_PORT"
            if [ -z "$node1_vip_eth" ]
            then
                    echo "cmrctl add cluster --name cls0 --incnet net0 --cfile $cfile_path/CMFILE_cls0"
                    echo "cmrctl start cluster --name cls0"            
                    if [ "$tibero_observer_enable" == "Y" ] 
                    then
                        echo "cmrctl add service --name $DB_NAME --cname cls0 --tscid 11 --obsip $observer_ip --obsport $CM_OBSERVER_PORT"
                    elif [ "$tibero_observer_enable" == "N" ] || [ -z "$tibero_observer_enable" ]
                    then
                        echo "cmrctl add service --name $DB_NAME --cname cls0 --tscid 11"
                    fi                    
                    echo "cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME --envfile $profile_path"
                else
                    echo "cmrctl add network --name pub0 --nettype public --ifname $node1_vip_eth"
                    echo "cmrctl add cluster --name cls0 --incnet net0 --pubnet pub0 --cfile $cfile_path/CMFILE_cls0"
                    echo "cmrctl start cluster --name cls0"
                    if [ "$tibero_observer_enable" == "Y" ] 
                    then
                        echo "cmrctl add service --name $DB_NAME --cname cls0 --tscid 11 --obsip $observer_ip --obsport $CM_OBSERVER_PORT"
                    elif [ "$tibero_observer_enable" == "N" ] || [ -z "$tibero_observer_enable" ]
                    then
                        echo "cmrctl add service --name $DB_NAME --cname cls0 --tscid 11"
                    fi                    
                    echo "cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME --envfile $profile_path"
                    echo "cmrctl add vip --name vip0 --svcname $DB_NAME --ipaddr $node1_vip_ip"
            fi
        elif [ "$tibero_node" == "standby" ]
        then
           echo "cmrctl add network --name net1 --ipaddr $NODE2_INTER_IP --portno $TBCM_NET_PORT"
                if [ -z "$node2_vip_eth" ]
                then
                    echo "cmrctl add cluster --name cls1 --incnet net1 --cfile $cfile_path/CMFILE_cls1"
                    echo "cmrctl start cluster --name cls1"
                    if [ "$tibero_observer_enable" == "Y" ] 
                    then
                        echo "cmrctl add service --name $DB_NAME --cname cls1 --tscid 11 --obsip $observer_ip --obsport $CM_OBSERVER_PORT"
                    elif [ "$tibero_observer_enable" == "N" ] || [ -z "$tibero_observer_enable" ]
                    then
                        echo "cmrctl add service --name $DB_NAME --cname cls1 --tscid 11"
                    fi
                    echo "cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME --envfile $profile_path"
                else
                    echo "cmrctl add network --name pub1 --nettype public --ifname $node2_vip_eth"
                    echo "cmrctl add cluster --name cls1 --incnet net1 --pubnet pub1 --cfile $cfile_path/CMFILE_cls1"
                    echo "cmrctl start cluster --name cls1"
                    if [ "$tibero_observer_enable" == "Y" ] 
                    then
                        echo "cmrctl add service --name $DB_NAME --cname cls1 --tscid 11 --obsip $observer_ip --obsport $CM_OBSERVER_PORT"
                    elif [ "$tibero_observer_enable" == "N" ] || [ -z "$tibero_observer_enable" ]
                    then
                        echo "cmrctl add service --name $DB_NAME --cname cls1 --tscid 11"
                    fi
                    echo "cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME --envfile $profile_path"
                    echo "cmrctl add vip --name vip1 --svcname $DB_NAME --ipaddr $node2_vip_ip"
                fi
        elif [ "$tibero_node" == "observer" ]
        then
            2>/dev/null
        fi
    elif [ "$tibero_type" == "TAC" ]
    then
       2>/dev/null
        if [ "$tibero_node" == "cm0" ]
        then
            echo "cmrctl add network --name net0 --ipaddr $NODE1_INTER_IP --portno $TBCM_NET_PORT"
            if [ -z "$node1_vip_eth" ]
            then
                echo "cmrctl add cluster --name cls0 --incnet net0 --cfile $cfile_path/CMFILE"
                echo "cmrctl start cluster --name cls0"
                echo "cmrctl add service --name $DB_NAME --cname cls0 --type db"
                echo "cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME"
            else
                echo "cmrctl add network --name pub0 --nettype public --ifname $node1_vip_eth"
                echo "cmrctl add cluster --name cls0 --incnet net0 --pubnet pub0 --cfile $cfile_path/CMFILE"
                echo "cmrctl start cluster --name cls0"
                echo "cmrctl add service --name $DB_NAME --cname cls0 --type db"
                echo "cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME"
                echo "cmrctl add vip --name vip0 --svcname $DB_NAME --ipaddr $node1_vip_ip"
            fi
        elif [ "$tibero_node" == "cm1" ]
        then
            echo "cmrctl add network --name net1 --ipaddr $NODE2_INTER_IP --portno $TBCM_NET_PORT"
            if [ -z "$node2_vip_eth" ]
            then
                echo "cmrctl add cluster --name cls0 --incnet net1  --cfile $cfile_path/CMFILE"
                echo "cmrctl start cluster --name cls0"
                echo "cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME"
            else
                echo "cmrctl add network --name pub1 --nettype public --ifname $node2_vip_eth"
                echo "cmrctl add cluster --name cls0 --incnet net1 --pubnet pub1 --cfile $cfile_path/CMFILE"
                echo "cmrctl start cluster --name cls0"
                echo "cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME"
                echo "cmrctl add vip --name vip1 --svcname $DB_NAME --ipaddr $node2_vip_ip"
            fi
        fi
    elif [ "$tibero_type" == "SINGLE" ]
    then
        echo
        echo "  message> tbis.cfg - tibero_type : " $tibero_type
        echo
    elif [ "$tibero_type" == "observer" ]
    then
        echo
        echo "  message> tbis.cfg - tibero_type : " $tibero_type
        echo
    fi    
}


# profile mode check
# apply: create profile file
# output: display output
cfg_cm_mode=$1
cfg_cm_type=$2
if [ -z $"cfg_cm_mode" ]
then
    2>/dev/null
elif [ "$cfg_cm_mode" == "apply" ]
then
    if [ "$cfg_cm_type" == "cm_tip" ]
    then
        fun_cm_tip >> "$TB_HOME"/config/"$CM_SID".tip
    elif [ "$fun_cm_tip" == "cm_resource" ]
    then
        fun_cm_resource >> "$TB_HOME"/config/"$CM_SID".tip
    fi
elif [ "$cfg_cm_mode" == "output" ]
then
    if [ "$cfg_cm_type" == "cm_tip" ]
    then
        fun_cm_tip
    elif [ "$fun_cm_tip" == "cm_resource" ]
    then
        fun_cm_resource
    fi
fi
