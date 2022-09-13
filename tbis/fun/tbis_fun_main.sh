#!/bin/sh
############################################################
# Program variables
############################################################
# 
tbis_current_path=`pwd`


############################################################
#
############################################################
# 
mkdir -p log 2>/dev/null


############################################################
# main
############################################################
#
clear
echo "[*] TIBERO Installation Shell Script"
echo "[*] This script is for TmaxTibero Daejeon Office only."
echo "[*] Supported Version : Tibero 6 FS07 ↑"
echo "-----------------------------------------------------------------"
echo "# 1. Installation"
echo "# 2. Installation report"
echo "# 3. Installation configuration"
echo "-----------------------------------------------------------------"
echo "# press other key to quit"
echo "-----------------------------------------------------------------"
printf "Choose the Number : "
 
if [ "$tbis_mode" == "docker" ]
then
    input_number="1"
fi

if [ -z "$input_number" ]
then
    read input_number
fi

case $input_number in
    1)
        file_time=`date +%F_%T |sed 's/://g' |sed 's/-//g'`
        . cfg/tbis_cfg_main.sh
        . fun/tbis_fun_error.sh
        if [ "$tibero_type" == "SINGLE" ]
        then
            . fun/tbis_fun_single.sh |tee log/tbis_install_"$file_time".log
        elif [ "$tibero_type" == "TSC" ]
        then
            . fun/tbis_fun_tsc.sh |tee log/tbis_install_"$file_time".log
        elif [ "$tibero_type" == "TAC" ]
        then
            . fun/tbis_fun_tac.sh |tee log/tbis_install_"$file_time".log
        fi
        
        ;;
    2)
        clear
        . fun/tbis_fun_report.sh;;
    3)
        echo;;
    *)
        echo "tbis message> program exit"
        exit 1;;
esac
