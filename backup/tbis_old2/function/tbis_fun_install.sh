# display clear
clear

# program select list
echo "[*] tbis Installation configuration"
echo "-----------------------------------------------------------------"    
echo " * Installation mode"
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
echo " - CHARACTER SET : `cat $tbis_current_path/sql/credb.sql |grep CHARACTER |awk '{print $NF}'`"
echo " - ARCHIVE MODE : `cat $tbis_current_path/sql/credb.sql |grep -Ew "NOARCHIVELOG|ARCHIVELOG" |awk '{print $1}'`"
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
cat $tbis_current_path/sql/credb.sql
echo "-----------------------------------------------------------------"
echo ""
printf "continue ? ( [Y]es / [N]o / [AA] All Auto] ) : "


# docker mode check
if [ "$tbis_mode" == "docker" ]
then
	input_str="AA"
else
	read intput_str
fi

#
case $intput_str in
	"Y"|"y")
		# all auto mode check
		export all_auto_enable="N"

		# tibero type check
		if [ "$tibero_type" == "SINGLE" ]
		then
			. $tbis_current_path/function/tbis_fun_install_single.sh
		elif [ "$tibero_type" == "TSC" ]
		then
			. $tbis_current_path/function/tbis_fun_install_tsc.sh
		elif [ "$tibero_type" == "TAC" ]
		then
			. $tbis_current_path/function/tbis_fun_install_tac.sh
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
			. $tbis_current_path/function/tbis_fun_install_single.sh
		elif [ "$tibero_type" == "TSC" ]
		then
			. $tbis_current_path/function/tbis_fun_install_tsc.sh
		elif [ "$tibero_type" == "TAC" ]
		then
			. $tbis_current_path/function/tbis_fun_install_tac.sh
		fi		
		;;
	*)
	        echo "tbis message> program exit"
        	exit 1
		;;
esac

