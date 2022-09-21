# display clear
clear

#
echo "[*] Installation configuration"
echo "-----------------------------------------------------------------"
echo "# Installation mode"
echo "- tibero type: $tibero_type"
echo "- tibero node: $tibero_node"
echo "-----------------------------------------------------------------"
echo "# directory configuration"
echo " dir1. directory structure"
echo "-----------------------------------------------------------------"
echo "# os configuration"
echo " os1. OS user and group"
echo " os2. OS user profile"
echo "-----------------------------------------------------------------"
echo "# db configuration"
echo " db1. instance tip"
echo " db2. tbdsn.tbr"
echo "-----------------------------------------------------------------"
echo "# cm configuration"
echo " cm1. cm tip"
echo " cm2. cm resource"
echo "-----------------------------------------------------------------"
echo " b - before"
echo " press other key to quit"
echo "-----------------------------------------------------------------"
printf "Choose the Number : "
read input_number

# display clear
clear

case $input_number in
	"dir1")
		. $tbis_current_path/config/tbis_cfg_directory_structure.sh
		. $tbis_current_path/fun/tbis_fun_common.sh press
		read wait_key
		. $tbis_current_path/fun/tbis_fun_cfgtext.sh
		;;
	"b")
		$env_shell $tbis_current_path/fun/tbis_fun_main.sh
		echo 
	;;
	*)
		echo "tbis message> program exit"
		exit
	;;
esac
