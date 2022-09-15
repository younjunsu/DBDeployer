#!/bin/sh
############################################################
# Program variables
############################################################
#

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
echo " 1. Installation"
echo " 2. Installation report"
echo " 3. Installation configuration"
echo " (not yet) 4. Installation security vulnerability"
echo "-----------------------------------------------------------------"
echo " press other key to quit"
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
        . $tbis_current_path/tbis.cfg
        . $tbis_current_path/fun/tbis_fun_error.sh
        if [ "$tibero_type" == "SINGLE" ]
        then
            . $tbis_current_path/fun/tbis_fun_install_single.sh |tee log/tbis_install_"$file_time".log
        elif [ "$tibero_type" == "TSC" ]
        then
            . $tbis_current_path/fun/tbis_fun_install_tsc.sh |tee log/tbis_install_"$file_time".log
        elif [ "$tibero_type" == "TAC" ]
        then
            . $tbis_current_path/fun/tbis_fun_install_tac.sh |tee log/tbis_install_"$file_time".log
        fi
        ;;
    2)
        clear
        . $tbis_current_path/tbis.cfg
        . $tbis_current_path/fun/tbis_fun_report.sh
        ;;
    3)
        clear
        . $tbis_current_path/tbis.cfg
        . $tbis_current_path/fun/tbis_fun_cfgtext.sh
        ;;
    *)
        echo "tbis message> program exit"
        exit 1
        ;;
esac
