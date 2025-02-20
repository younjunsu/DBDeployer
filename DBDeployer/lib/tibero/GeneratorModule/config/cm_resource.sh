#
#--------------------------------------------------------------------------------
function fn_cm_resource(){
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
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
fn_cm_resource
#--------------------------------------------------------------------------------