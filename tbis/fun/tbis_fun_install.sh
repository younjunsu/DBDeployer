# display clear
clear

#
echo "[*] Installation configuration"
echo "-----------------------------------------------------------------"    
echo "Installation mode"
echo "-----------------------------------------------------------------"    
echo "- tibero type : $tibero_type"
echo "- tibero node : $tibero_node"
echo "-----------------------------------------------------------------"    
echo "OS Configuration"
echo "-----------------------------------------------------------------"    
echo " # install user: $tbis_run_user"
echo " - user name : $user_name"
echo " - user home : $user_home"
echo " - user group : $group_name"
echo "-----------------------------------------------------------------"    
echo "Database Configuration"
echo "-----------------------------------------------------------------"    
echo " - TB_HOME : $TB_HOME"
echo " - TB_SID : $TB_SID"
echo " - DB_NAME : $DB_NAME"
echo " - LISTENER_PORT : $LISTENER_PORT"
echo " - CHARACTER SET : `cat $tbis_current_path/sql/credb.sql |grep CHARACTER |awk '{print $NF}'`"
echo " - ARCHIVE MODE : `cat $tbis_current_path/sql/credb.sql |grep -Ew "NOARCHIVELOG|ARCHIVELOG" |awk '{print $1}'`"
echo "-----------------------------------------------------------------"    
echo "Cluster Manager Configuration"
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
echo "-----------------------------------------------------------------"
echo "FILE PATH Configuration"
echo "-----------------------------------------------------------------"
echo " - TB_HOME PATH : $TB_HOME"
echo " - TBINARY PATH : $TB_HOME/tbinary"
echo " - CONTROL1_FILE : $CONTROL_FILE_PATH1/tbctl1/c1.ctl"
echo " - CONTROL2_FILE : $CONTROL_FILE_PATH2/tbctl2/c2.ctl"
echo " - DB_CREATE_FILE : $DB_CREATE_FILE_DEST/tbdata"
echo "-----------------------------------------------------------------"
echo "create database query"
echo "-----------------------------------------------------------------"
cat $tbis_current_path/sql/credb.sql
echo "-----------------------------------------------------------------"
printf "continue ? ( [Y]es / [N]o / [AA] All Auto] ) : "

if [ "$tbis_mode" == "docker" ]
then
	input_str="AA"
else
	read intput_str
fi

case $intput_str in
	"Y"|"y")
		echo Y
		;;
	"N"|"n")
		echo N
		;;
	"AA"|"aa")
		echo AA
		;;
	*)
	        echo "tbis message> program exit"
        	exit 1
		;;
esac
