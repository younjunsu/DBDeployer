#
#--------------------------------------------------------------------------------
function fn_profile(){
    echo "#############################"
    echo "# TIBERO environment variable"
    echo "#############################"
    echo "#### SHELL"
    echo "stty erase ^H"
    echo "export PS1=[\\\\u\"@\"\\\\h\" \"\\\\W]\\$\" \""
    echo "export EDITOR=vim"
    echo ""
    echo "#### JAVA"
    echo "#export JAVA_HOME="
    echo ""
    if [ "$tibero_type" == "SINGLE" ]
    then
        echo "#### SINGLE"
        echo "export TB_SID=`echo $DB_NAME`"
        export TB_SID=`echo "$DB_NAME"`
        echo "export TB_HOME=$TB_HOME"
    elif [ "$tibero_type" == "TSC" ]
    then
        echo "#### TSC (Tibero Standby Cluster)"
        if [ "$tibero_node" == "primary" ]
        then
            echo "export TB_SID=`echo $DB_NAME`_p"
            export TB_SID=`echo "$DB_NAME"_p`
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=primary"
            echo "export CM_HOME=\$TB_HOME"
        elif [ "$tibero_node" == "standby" ]
        then
            echo "export TB_SID=`echo $DB_NAME`_s"
            export TB_SID=`echo "$DB_NAME"_s`
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=standby"
            echo "export CM_HOME=\$TB_HOME"
        elif [ "$tibero_node" == "observer" ]
        then
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=observer"
            echo "export CM_HOME=\$TB_HOME"
        fi
    elif [ "$tibero_type" == "TAC" ]
    then
        echo "#### TAC (Tibero Active Cluster)"
        if [ "$tibero_node" == "cm0" ]
        then
            echo "export TB_SID=`echo $DB_NAME`0"
            export TB_SID=`echo "$DB_NAME"0`
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=cm0"
            echo "export CM_HOME=\$TB_HOME"
        elif [ "$tibero_node" == "cm1" ]
        then
            echo "export TB_SID=`echo $DB_NAME`1"
            export TB_SID=`echo "$DB_NAME"1`
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=cm1"
            echo "export CM_HOME=\$TB_HOME"
        fi
    fi
    echo ""
    echo "### TIBERO"
    echo "export TB_PROF_DIR=\$TB_HOME/bin/prof"
    echo "export LD_LIBRARY_PATH=\$TB_HOME/lib:\$TB_HOME/client/lib"
    echo "export LIBPATH=\$LD_LIBRARY_PATH"
    echo "export SHLIB_PATH=\$LD_LIBRARY_PATH"
    echo "export PATH=\$PATH:\$TB_HOME/bin:\$TB_HOME/client/bin:\$JAVA_HOME/bin"
    echo ""
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
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
function fn_instance_tip(){
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
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
function fn_tbdsn(){
    echo "$TB_SID=("
    echo "  (INSTANCE=(HOST=localhost)"
    echo "  (PORT=$LISTENER_PORT)"
    echo "  (DB_NAME=$DB_NAME)"
    echo "  )"
    echo ")"
}
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
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
function fn_cm_resource_command(){
        if [ "$tibero_type" == "TSC" ]
    then
        if [ "$tibero_node" == "primary" ]
        then
            cmrctl add network --name net0 --ipaddr $NODE1_INTER_IP --portno $TBCM_NET_PORT
            if [ -z "$node1_vip_eth" ]
            then
                    cmrctl add cluster --name cls0 --incnet net0 --cfile $cfile_path/CMFILE_cls0
                    cmrctl start cluster --name cls0           
                    if [ "$tibero_observer_enable" == "Y" ] 
                    then
                        cmrctl add service --name $DB_NAME --cname cls0 --tscid 11 --obsip $observer_ip --obsport $CM_OBSERVER_PORT
                    elif [ "$tibero_observer_enable" == "N" ] || [ -z "$tibero_observer_enable" ]
                    then
                        cmrctl add service --name $DB_NAME --cname cls0 --tscid 11
                    fi                    
                    cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME --envfile $profile_path
                else
                    cmrctl add network --name pub0 --nettype public --ifname $node1_vip_eth
                    cmrctl add cluster --name cls0 --incnet net0 --pubnet pub0 --cfile $cfile_path/CMFILE_cls0
                    cmrctl start cluster --name cls0
                    if [ "$tibero_observer_enable" == "Y" ] 
                    then
                        cmrctl add service --name $DB_NAME --cname cls0 --tscid 11 --obsip $observer_ip --obsport $CM_OBSERVER_PORT
                    elif [ "$tibero_observer_enable" == "N" ] || [ -z "$tibero_observer_enable" ]
                    then
                        cmrctl add service --name $DB_NAME --cname cls0 --tscid 11
                    fi                    
                    cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME --envfile $profile_path
                    cmrctl add vip --name vip0 --svcname $DB_NAME --ipaddr $node1_vip_ip
            fi
        elif [ "$tibero_node" == "standby" ]
        then
           cmrctl add network --name net1 --ipaddr $NODE2_INTER_IP --portno $TBCM_NET_PORT
                if [ -z "$node2_vip_eth" ]
                then
                    cmrctl add cluster --name cls1 --incnet net1 --cfile $cfile_path/CMFILE_cls1
                    cmrctl start cluster --name cls1
                    if [ "$tibero_observer_enable" == "Y" ] 
                    then
                        cmrctl add service --name $DB_NAME --cname cls1 --tscid 11 --obsip $observer_ip --obsport $CM_OBSERVER_PORT
                    elif [ "$tibero_observer_enable" == "N" ] || [ -z "$tibero_observer_enable" ]
                    then
                        cmrctl add service --name $DB_NAME --cname cls1 --tscid 11
                    fi
                    cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME --envfile $profile_path
                else
                    cmrctl add network --name pub1 --nettype public --ifname $node2_vip_eth
                    cmrctl add cluster --name cls1 --incnet net1 --pubnet pub1 --cfile $cfile_path/CMFILE_cls1
                    cmrctl start cluster --name cls1
                    if [ "$tibero_observer_enable" == "Y" ] 
                    then
                        cmrctl add service --name $DB_NAME --cname cls1 --tscid 11 --obsip $observer_ip --obsport $CM_OBSERVER_PORT
                    elif [ "$tibero_observer_enable" == "N" ] || [ -z "$tibero_observer_enable" ]
                    then
                        cmrctl add service --name $DB_NAME --cname cls1 --tscid 11
                    fi
                    cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME --envfile $profile_path
                    cmrctl add vip --name vip1 --svcname $DB_NAME --ipaddr $node2_vip_ip
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
            cmrctl add network --name net0 --ipaddr $NODE1_INTER_IP --portno $TBCM_NET_PORT
            if [ -z "$node1_vip_eth" ]
            then
                cmrctl add cluster --name cls0 --incnet net0 --cfile $cfile_path/CMFILE
                cmrctl start cluster --name cls0
                cmrctl add service --name $DB_NAME --cname cls0 --type db
                cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME
            else
                cmrctl add network --name pub0 --nettype public --ifname $node1_vip_eth
                cmrctl add cluster --name cls0 --incnet net0 --pubnet pub0 --cfile $cfile_path/CMFILE
                cmrctl start cluster --name cls0
                cmrctl add service --name $DB_NAME --cname cls0 --type db
                cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME
                cmrctl add vip --name vip0 --svcname $DB_NAME --ipaddr $node1_vip_ip
            fi
        elif [ "$tibero_node" == "cm1" ]
        then
            cmrctl add network --name net1 --ipaddr $NODE2_INTER_IP --portno $TBCM_NET_PORT
            if [ -z "$node2_vip_eth" ]
            then
                cmrctl add cluster --name cls0 --incnet net1  --cfile $cfile_path/CMFILE
                cmrctl start cluster --name cls0
                cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME
            else
                cmrctl add network --name pub1 --nettype public --ifname $node2_vip_eth
                cmrctl add cluster --name cls0 --incnet net1 --pubnet pub1 --cfile $cfile_path/CMFILE
                cmrctl start cluster --name cls0
                cmrctl add db --name $TB_SID --svcname $DB_NAME --dbhome $TB_HOME
                cmrctl add vip --name vip1 --svcname $DB_NAME --ipaddr $node2_vip_ip
            fi
        fi
    elif [ "$tibero_type" == "SINGLE" ]
    then
        echo ""
        echo "message> tbis.cfg - tibero_type : " $tibero_type
        echo ""
    elif [ "$tibero_type" == "observer" ]
    then
        echo ""
        echo " message> tbis.cfg - tibero_type : " $tibero_type
        echo ""
    fi
}
#--------------------------------------------------------------------------------




#
#--------------------------------------------------------------------------------
generator_type1=$1
generator_type2=$2

case $generator_type1 in
    "fn_profile")
        if [ "$generator_type2" == "apply" ]
        then
            fn_profile >> $profile_path
        elif [ "$generator_type2" == "output" ]
        then
            fn_profile
        fi
        ;;
    "fn_instance_tip")
        if [ "$generator_type2" == "apply" ]
        then
            fn_instance_tip >> "$TB_HOME"/config/"$TB_SID".tip
        elif [ "$generator_type2" == "output" ]
        then
            fn_instance_tip
        fi
        ;;
    "fn_tbdsn")
        if [ "$generator_type2" == "apply" ]
        then
            fn_tbdsn >> "$TB_HOME"/client/config/tbdsn.tbr
        elif [ "$generator_type2" == "output" ]
        then
            fn_tbdsn
        fi    
        ;;        
    "fn_cm_tip")
        if [ "$generator_type2" == "apply" ]
        then
            fn_cm_tip >> "$TB_HOME"/config/"$CM_SID".tip
        elif [ "$generator_type2" == "output" ]
        then
            fn_cm_tip
        fi    
        ;;
    "fn_cm_resource")
        if [ "$generator_type2" == "apply" ]
        then
            fn_cm_resource >> "$TB_HOME"/config/"$CM_SID".tip
        elif [ "$generator_type2" == "output" ]
        then
            fn_cm_resource_command
        fi       
        ;;
    *)
        2>/dev/null
        ;;
esac
#--------------------------------------------------------------------------------