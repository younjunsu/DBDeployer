############################################################
# run user mode
############################################################
#if [ "$tbis_run_user" == "root" ] && [ "$user_name" == "root" ] || [ "$tbis_run_user" != "root" ]
#then
#	export tbis_run_user_mode="no_switch"
#elif [ "$tbis_run_user" != "$user_name" ] && [ "$tbis_run_user" == "root" ]
#then
#	export tbis_run_user_mode="switch"
#fi

############################################################
# shell action
############################################################
fun_change_owner(){
	if [ "$tbis_run_user_mode" == "no_swtich" ]
	then
		#chown -R $user_home:$group_name $user_home
		#chown -R $user_home:$group_name $tb_home
		2>/dev/null
	elif [ "$tbis_run_user_mode" == "switch" ]
	then
		su - $user_name -c "chown -R $user_home:$group_name $user_home"
		su - $user_name -c "chown -R $user_home:$group_name $tb_home"
	fi
}

############################################################
# tibero action
############################################################
fun_tbboot(){
	input_action=$1

	# display output message
	echo "############################################################"
	echo "#  tbis Progress> tbboot"
	echo "############################################################"
	echo "# install user : $tbis_run_user"
	echo "# tibero  user : $user_name"
	echo "----------------------------------------------------"
	echo "tbboot " $input_action
	echo "----------------------------------------------------"
	echo

	# action
	case $input_action in
		"mount")
			if [ "$tbis_run_user_mode" == "no_swtich" ]
			then
				tbobot mount
			elif [ "$tbis_run_user_mode" == "switch" ]
			then
				su - $user_name -c "tbobot mount"
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
}

fun_tbdown(){
	input_action=$1

	# display output message
	echo "############################################################"
	echo "#  tbis Progress> tbdown"
	echo "############################################################"
	echo "# install user : $tbis_run_user"
	echo "# tibero  user : $user_name"
	echo "----------------------------------------------------"
	echo "tbdown " $input_action
	echo "----------------------------------------------------"
	echo

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
}

fun_cm_bootdown(){
	input_action=$1
	echo
	echo "############################################################"
	echo "# tbis Progress> tbcm boot or down "    
	echo "############################################################"
	echo "# install user : $tbis_run_user"
	echo "# tibero  user : $user_name"
	echo

	case $intput_action in
		"boot")
			if [ "$tbis_run_user_mode" == "no_swtich" ]
			then
				tbcm -b
			elif [ "$tbis_run_user_mode" == "switch" ]
			then
				su - $user_name -c "tbcm -b"
			fi		
		"donw")
			if [ "$tbis_run_user_mode" == "no_swtich" ]
			then
				tbcm -d
			elif [ "$tbis_run_user_mode" == "switch" ]
			then
				su - $user_name -c "tbcm -d"
			fi
			;;
		*)
			2>/dev/null
			;;
	esac
}


# function type
input_type=$1

# action  type
input_tibero_action=$2

#switch type
# no_switch
# switch
tbis_run_user_mode=$3

case $input_type in
	"chang_owner")
		fun_change_owner
		;;
	"cmboot")
		fun_cm_bootdown $input_tibero_action
		;;
	"cmdown")
		fun_cm_bootdown $input_tibero_action
		;;
	"tbboot")
		fun_tbboot $input_tibero_action
		;;
	"tbdown")
		fun_tbdown $input_tibero_action
		;;
	"credb")

		;;
	"system.sh")
			$tbis_shell $TB_HOME/scripts/system.sh -p1 tibero -p2 syscat -a1 Y -a2 Y -a3 Y -a4 Y
		;;	
	*)
		;;
esac
