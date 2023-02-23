# 
#-------------------------------------------------------------------------------
clear
#-------------------------------------------------------------------------------


#
#-------------------------------------------------------------------------------
function fn_install_type_menu(){
    echo "[*] TIBERO DBDeployer Installation configuration"
    echo "-----------------------------------------------------------------"    
    echo " * TIBERO Mode"
    echo "-----------------------------------------------------------------"    
    echo " - tibero type : $tibero_type"
    echo " - tibero node : $tibero_node"
    echo "-----------------------------------------------------------------"    
    echo " * OS Configuration"
    echo "-----------------------------------------------------------------"    
    echo " - install user: $tbis_run_user"
    echo " - user name : $user_name"
    echo " - user home : $user_home"
    echo " - user group : $group_name"
    echo "-----------------------------------------------------------------"    
    echo " * Database Configuration"
    echo "-----------------------------------------------------------------"
    echo " - TB_SID : $TB_SID"
    echo " - TB_HOME : $TB_HOME"
    echo " - DB_NAME : $DB_NAME"
    echo " - LISTENER_PORT : $LISTENER_PORT"
    echo " - CHARACTER SET : `cat $current_path/sql/credb.sql |grep CHARACTER |awk '{print $NF}'`"
    echo " - ARCHIVE MODE : `cat $current_path/sql/credb.sql |grep -Ew "NOARCHIVELOG|ARCHIVELOG" |awk '{print $1}'`"
    if [ "$tibero_node" == "SINGLE" ] || [ "$tibero_node" == "observer" ]
    then
        2>/dev/null
    else
        echo "-----------------------------------------------------------------"    
        echo " * Cluster Manager Configuration"
        echo "-----------------------------------------------------------------"
        echo " - CM_SID : $tibero_node"
        echo " - CM_HOME : $TB_HOME"
        echo "-------------"
        echo "Interconnect"
        echo "-------------"
        echo " - node1 interconnect IP : $node1_interconnect_ip"
        echo " - node2 interconnect IP : $node2_interconnect_ip"
        echo ""
        echo "-------------"
        echo "VIP enable"
        echo "-------------"
        echo " - node1 VIP IP : $node1_vip_ip" 
        echo " - node1 VIP ethernet : $node1_vip_eth"
        echo " - node2 VIP IP : $node2_vip_ip" 
        echo " - node2 VIP ethernet : $node2_vip_eth"
        echo "-------------"
        echo "VIP disable"
        echo "-------------"
    fi
    echo "-----------------------------------------------------------------"
    echo " * FILE PATH Configuration"
    echo "-----------------------------------------------------------------"
    echo " - USER_HOME PATH : $user_home"
    echo " - TBINARY PATH : $user_home/tbinary"
    echo " - TB_HOME PATH : $TB_HOME"
    echo " - CONTROL1_FILE : $CONTROL_FILE_PATH1_CFG"
    echo " - CONTROL2_FILE : $CONTROL_FILE_PATH2_CFG"
    echo " - DB_CREATE_FILE : $DB_CREATE_FILE_DEST_CFG"
    echo " - LOG_ARCHIVE_DEST : $LOG_ARCHIVE_DEST_CFG"
    echo "-----------------------------------------------------------------"
    echo " * CREATE DATABASE sql"
    echo "-----------------------------------------------------------------"
    cat $current_path/config/tibero_credb.sql
    echo "-----------------------------------------------------------------"
    echo ""
    printf "continue ? ( [Y]es / [N]o / [AA] All Auto] ) : "
}
#-------------------------------------------------------------------------------


#
#-------------------------------------------------------------------------------
fn_install_type_menu

if [ "$mode" == "auto" ]
then
    press_key="AA"
elif [ "$mode" == "run" ]
then
    read press_key
else
    exit
fi

case $press_key in 
    "Y"|"y")
		# all auto mode check
		export all_auto_enable="N"

		# tibero type check
		if [ "$tibero_type" == "SINGLE" ]
		then
			. $tbis_current_path/lib/tibero/install/single.sh
		elif [ "$tibero_type" == "TSC" ]
		then
			. $tbis_current_path/lib/tibero/install/tsc.sh
		elif [ "$tibero_type" == "TAC" ]
		then
			. $tbis_current_path/lib/tibero/install/tac.sh
		fi    
        ;;
    "N"|"n")
        exit
        ;;
    "AA"|"aa")
		# all auto mode check
		export all_auto_enable=Y

		# tibero type check
		if [ "$tibero_type" == "SINGLE" ]
		then
			. $tbis_current_path/lib/tibero/install/single.sh
		elif [ "$tibero_type" == "TSC" ]
		then
			. $tbis_current_path/lib/tibero/install/tsc.sh
		elif [ "$tibero_type" == "TAC" ]
		then
			. $tbis_current_path/lib/tibero/install/tac.sh
		fi      
        ;;
    *)
        exit
        ;;
esac
#-------------------------------------------------------------------------------

