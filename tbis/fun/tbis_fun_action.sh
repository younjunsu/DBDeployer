############################################################
# run user mode
############################################################


############################################################
# shell action
############################################################
fun_change_owner(){
    echo "############################################################"
    echo "#  tbis Progress> Change Owner"
    echo "############################################################"
	echo
	echo "chown -R $user_home:$group_name $user_home"
	echo	
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

fun_system_shell(){
	if [ "$tbis_run_user_mode" == "no_swtich" ]
	then
		$tbis_shell $TB_HOME/scripts/system.sh -p1 tibero -p2 syscat -a1 Y -a2 Y -a3 Y -a4 Y
	elif [ "$tbis_run_user_mode" == "switch" ]
	then
		su - $user_name -c "$tbis_shell $TB_HOME/scripts/system.sh -p1 tibero -p2 syscat -a1 Y -a2 Y -a3 Y -a4 Y"
	fi	
}

fun_credb(){
	echo
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


fun_install(){
	echo
	echo "############################################################"
	echo "# tbis Progress> Engine"
	echo "############################################################"
	echo
	echo "gunzip ../binary/tibero*.tar.gz"
	echo "tar -xvf ../binary/tibero*.tar -C $USER_HOME"
	echo

}

fun_license(){
    echo
    echo "############################################################"
    echo "# tbis Progress> license "    
    echo "############################################################"
    echo
    echo "cp ../binary/license.xml $TB_HOME/license/license.xml"
    echo	
}

fun_tbinary(){
	echo
	echo "############################################################"
	echo "# tbis Progress> tbinary"
	echo "############################################################"
	echo
	echo "tar -xvf ../binary/tbinary*.tar -C $USER_HOME"
	echo
}

# action  type
input_tibero_action=$2


case $input_type in
	"install")
		
		;;
	"license")

		;;
	"tbinary")

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
		fun_credb
		;;
	"system.sh")
		fun_system_shell
		;;
	"chang_owner")
		fun_change_owner
		;;			
	*)
		;;
esac
