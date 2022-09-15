############################################################
# shell action
############################################################
fun_change_owner(){
 	echo
}

############################################################
# tibero action
############################################################
fun_tbboot(){
	input_action=$1
	
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
