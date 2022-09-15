############################################################
# shell action
############################################################
fun_change_owner(){
	chown -R $USER_NAME:$GROUP_NAME $USER_HOME
        chown -R $USER_NAME:$GROUP_NAME $TB_HOME
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
	echo "----------------------------------------------------"
	echo "tbboot " $input_action
	echo "----------------------------------------------------"
	echo

	# action
	case $input_action in
		"mount")
			tbobot mount
			;;
		"normal")
			tbboot normal
			;;
		"recovery")
			tbboot recovery
			;;
		*)
			;;
	esac
}

fun_tbdown(){
	input_action=$1

	# display output message
	echo "############################################################"
        echo "#  tbis Progress> tbdown"
        echo "############################################################"
        echo "----------------------------------------------------"
        echo "tbdown " $input_action
        echo "----------------------------------------------------"
        echo

	# action
	case $input_action in
		"normal")
			tbdown normal
			;;
		"immediate")
			tbdown immediate
			;;
		*)
			;;
	esac
}

fun_cm_bootdown(){
	input_action=$1
	echo
    	echo "############################################################"
    	echo "# tbis Progress> tbcm boot "    
    	echo "############################################################"
	echo

	case $intput_action in
		"boot")
			tbcm -b
		"donw")
			tbcm -d
			;;
		*)
			;;
	esac
}


#
input_type=$1
input_tibero_action=$2

#
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
	*)
		;;
esac
