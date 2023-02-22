############################################################
# run user mode
############################################################

fun_process_chk(){
	echo
	echo "############################################################"
	echo "# tbis Progress> tbis installation check"
	echo "############################################################"
	echo
	. $tbis_current_path/function/tbis_fun_common.sh progress_chk
	if [ "$all_auto_enable" == "Y" ]
	then
		progress_yesno="YES"
	fi

	if [ "$progress_yesno" == "YES" ]
    then
		ps -ef |grep "$user_name" | grep tbsvr
		echo
		ls -rlt $TB_HOME
		ls -rlt $DB_CREATE_FILE_DEST_CFG
		ls -rlt $CONTROL_FILE_PATH1_CFG
		ls -rlt $CONTROL_FILE_PATH2_CFG
		ls -lrt $LOG_ARCHIVE_DEST_CFG
		echo
	fi


}
############################################################
# function action
############################################################
fun_engine(){
	echo
	echo "############################################################"
	echo "# tbis Progress> Engine"
	echo "############################################################"
	echo
	echo " - gunzip ../binary/tibero*.tar.gz"
	echo " - tar -xvf ../binary/tibero*.tar -C $TB_HOME"
	echo
	. $tbis_current_path/function/tbis_fun_common.sh progress_chk
	if [ "$all_auto_enable" == "Y" ]
	then
		progress_yesno="YES"
	fi

    if [ "$progress_yesno" == "YES" ]
    then
		gunzip ../binary/tibero*.tar.gz
		tar -xvf ../binary/tibero*.tar -C $user_home
    fi
}

fun_license(){
    echo
    echo "############################################################"
    echo "# tbis Progress> license "    
    echo "############################################################"
    echo
    echo " - cp ../binary/license.xml $TB_HOME/license/license.xml"
    echo
	. $tbis_current_path/function/tbis_fun_common.sh progress_chk
	if [ "$all_auto_enable" == "Y" ]
	then
		progress_yesno="YES"
	fi

    if [ "$progress_yesno" == "YES" ]
    then
        cp ../binary/license.xml $TB_HOME/license/license.xml
    fi		
}

fun_tbinary(){
	if [ "$tibero_tbinary" == "Y" ] || [ "$tibero_tbinary" == "y" ]
	then
		echo
		echo "############################################################"
		echo "# tbis Progress> tbinary"
		echo "############################################################"
		echo
		echo " - tar -xvf ../binary/tbinary*.tar -C $user_home"
		echo
		. $tbis_current_path/function/tbis_fun_common.sh progress_chk
		if [ "$all_auto_enable" == "Y" ]
		then
			progress_yesno="YES"
		fi

		if [ "$progress_yesno" == "YES" ]
		then
		 	tar -xvf ../binary/tbinary*.tar -C $user_home	
		fi
	fi
}

fun_change_owner(){
	echo
    echo "############################################################"
    echo "#  tbis Progress> Change Owner"
    echo "############################################################"
	echo
	echo " - chown -R $user_name:$group_name $user_home"
	echo
	. $tbis_current_path/function/tbis_fun_common.sh progress_chk
	if [ "$all_auto_enable" == "Y" ]
	then
		progress_yesno="YES"
	fi

	if [ "$progress_yesno" == "YES" ]
    then
		if [ "$tbis_run_user_mode" == "no_swtich" ]
		then
			#chown -R $user_name:$group_name $user_home
			#chown -R $user_name:$group_name $TB_HOME
			2>/dev/null
		elif [ "$tbis_run_user_mode" == "switch" ]
		then
			chown -R $user_name:$group_name $user_home
			chown -R $user_name:$group_name $TB_HOME
		fi       
    fi
	
}

############################################################
# tibero action
############################################################
fun_tbboot(){
	input_action=$1

	# display output message
	echo
	echo "############################################################"
	echo "#  tbis Progress> tbboot"
	echo "############################################################"
	echo "# install user : $tbis_run_user"
	echo "# tibero  user : $user_name"
	echo "----------------------------------------------------"
	if [ "$tbis_run_user_mode" == "no_switch" ]
	then
		echo " - tbboot $input_action"
	elif [ "$tbis_run_user_mode" == "switch" ]
	then
		echo " - su - $user_name -c \"tbboot $input_action\""
	fi	
	echo "----------------------------------------------------"
	echo
	. $tbis_current_path/function/tbis_fun_common.sh progress_chk
	if [ "$all_auto_enable" == "Y" ]
	then
		progress_yesno="YES"
	fi

	if [ "$progress_yesno" == "YES" ]
	then	
		# action
		case $input_action in
			"nomount")
				if [ "$tbis_run_user_mode" == "no_swtich" ]
				then
					tbboot nomount
				elif [ "$tbis_run_user_mode" == "switch" ]
				then
					su - $user_name -c "tbboot nomount"
				fi				
				;;
			"mount")
				if [ "$tbis_run_user_mode" == "no_swtich" ]
				then
					tbboot mount
				elif [ "$tbis_run_user_mode" == "switch" ]
				then
					su - $user_name -c "tbboot mount"
				fi
				;;
			"normal")
				if [ "$tbis_run_user_mode" == "no_swtich" ]
				then
					tbboot normal
				elif [ "$tbis_run_user_mode" == "switch" ]
				then
					su - $user_name -c "tbboot normal"
				fi
				;;
			"recovery")
				if [ "$tbis_run_user_mode" == "no_swtich" ]
				then
					tbboot recovery
				elif [ "$tbis_run_user_mode" == "switch" ]
				then
					su - $user_name -c "tbboot recovery"
				fi
				;;
			*)
				2>/dev/null
				;;
		esac
	fi	
}

fun_tbdown(){
	input_action=$1

	# display output message
	echo
	echo "############################################################"
	echo "#  tbis Progress> tbdown"
	echo "############################################################"
	echo "# install user : $tbis_run_user"
	echo "# tibero  user : $user_name"
	echo "----------------------------------------------------"
	if [ "$tbis_run_user_mode" == "no_switch" ]
	then
		echo " - tbdown $input_action"
	elif [ "$tbis_run_user_mode" == "switch" ]
	then
		echo " - su - $user_name -c \"tbdown $input_action\""
	fi
	echo "----------------------------------------------------"
	echo
	. $tbis_current_path/function/tbis_fun_common.sh progress_chk
	if [ "$all_auto_enable" == "Y" ]
	then
		progress_yesno="YES"
	fi

    if [ "$progress_yesno" == "YES" ]
    then	
		# action
		case $input_action in
			"normal")
				if [ "$tbis_run_user_mode" == "no_swtich" ]
				then
					tbdown normal
				elif [ "$tbis_run_user_mode" == "switch" ]
				then
					su - $user_name -c "tbdown normal"
				fi
				;;
			"immediate")
				if [ "$tbis_run_user_mode" == "no_swtich" ]
				then
					tbdown immediate
				elif [ "$tbis_run_user_mode" == "switch" ]
				then
					su - $user_name -c "tbdown immediate"
				fi
				;;
			*)
				2>/dev/null
				;;
		esac
	fi
}

fun_cm_boot(){
	echo
	echo "############################################################"
	echo "# tbis Progress> tbcm boot"
	echo "############################################################"
	echo "# install user : $tbis_run_user"
	echo "# tibero  user : $user_name"
	echo " - tbcm -b"
    . $tbis_current_path/function/tbis_fun_common.sh progress_chk
	if [ "$all_auto_enable" == "Y" ]
	then
		progress_yesno="YES"
	fi

    if [ "$progress_yesno" == "YES" ]
    then
		if [ "$tbis_run_user_mode" == "no_swtich" ]
		then
			tbcm -b
		elif [ "$tbis_run_user_mode" == "switch" ]
		then
			su - $user_name -c "tbcm -b"
		fi
	fi
}

fun_cm_down(){
	echo
	echo "############################################################"
	echo "# tbis Progress> tbcm down"
	echo "############################################################"
	echo "# install user : $tbis_run_user"
	echo "# tibero  user : $user_name"
	echo " - tbcm -d"
    . $tbis_current_path/function/tbis_fun_common.sh progress_chk
	if [ "$all_auto_enable" == "Y" ]
	then
		progress_yesno="YES"
	fi

    if [ "$progress_yesno" == "YES" ]
    then
		if [ "$tbis_run_user_mode" == "no_swtich" ]
		then
			tbcm -d
		elif [ "$tbis_run_user_mode" == "switch" ]
		then
			su - $user_name -c "tbcm -d"
		fi
	fi
}
fun_system_shell(){
	echo
    echo "############################################################"
    echo "#  tbis Progress> system.sh"
    echo "############################################################"
    echo
    echo "sh $TB_HOME/scripts/system.sh -p1 tibero -p2 syscat -a1 Y -a2 Y -a3 Y -a4 Y"
    echo	
	. $tbis_current_path/function/tbis_fun_common.sh progress_chk
	if [ "$all_auto_enable" == "Y" ]
	then
		progress_yesno="YES"
	fi

    if [ "$progress_yesno" == "YES" ]
    then
		if [ "$tbis_run_user_mode" == "no_swtich" ]
		then
			sh $TB_HOME/scripts/system.sh -p1 tibero -p2 syscat -a1 Y -a2 Y -a3 Y -a4 Y
		elif [ "$tbis_run_user_mode" == "switch" ]
		then
			su - $user_name -c "sh $TB_HOME/scripts/system.sh -p1 tibero -p2 syscat -a1 Y -a2 Y -a3 Y -a4 Y"
		fi	
	fi
}

fun_credb(){
    echo "############################################################"
    echo "#  tbis Progress> CREATE DATABASE"
    echo "############################################################"
	echo
	cat $tbis_current_path/sql/credb.sql
	echo
	. $tbis_current_path/function/tbis_fun_common.sh progress_chk
	if [ "$all_auto_enable" == "Y" ]
	then
		progress_yesno="YES"
	fi
		
    if [ "$progress_yesno" == "YES" ]
    then
		if [ "$tbis_run_user_mode" == "no_swtich" ]
		then
			tbsql -s sys/tibero < $tbis_current_path/sql/credb.sql
			echo
		elif [ "$tbis_run_user_mode" == "switch" ]
		then
			su - $user_name -c "tbsql -s sys/tibero < $tbis_current_path/sql/credb.sql "
			echo
		fi	
	fi
	sleep 1
}

# function type
input_type=$1

#switch type
# no_switch
# switch
if [ "$tbis_run_user" == "root" ] && [ "$user_name" == "root" ] || [ "$tbis_run_user" != "root" ]
then
	export tbis_run_user_mode="no_switch"
elif [ "$tbis_run_user" != "$user_name" ] && [ "$tbis_run_user" == "root" ]
then
	export tbis_run_user_mode="switch"
fi


# action  type
input_tibero_action=$2


case $input_type in
	"fun_engine")
		fun_engine
		;;
	"fun_license")
		fun_license
		;;
	"fun_tbinary")
		fun_tbinary
		;;
	"fun_cm_boot")
		fun_cm_bootdown $input_tibero_action
		;;
	"fun_cm_down")
		fun_cm_bootdown $input_tibero_action
		;;
	"fun_tbboot")
		fun_tbboot $input_tibero_action
		;;
	"fun_tbdown")
		fun_tbdown $input_tibero_action
		;;	
	"fun_credb")
		fun_credb
		;;
	"fun_system_shell")
		fun_system_shell
		;;
	"fun_change_owner")
		fun_change_owner
		;;
	"fun_process_chk")
		fun_process_chk
		;;		
	*)
		;;
esac
