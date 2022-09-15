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
	input_bootmode=$1
	
	case $input_bootmode in
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
	input_downmode=$1

	case $input_downmode in
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
	input_bootdown=$1
	
	case $intput_bootmode in
		"boot")
			tbcm -b
		"donw")
			tbcm -d
			;;
		*)
			;;
	esac
}

