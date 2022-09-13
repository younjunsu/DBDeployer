fun_num01_license_info(){
    echo "num01"
}

fun_num02_ncpu_info(){
    echo "num02"
}

fun_num03_install_info(){
    echo "num03"
}

fun_num04_profile_info(){
    echo "num04"
}

fun_num05_cresql_info(){
    echo "num05"
}

fun_num06_tip_info(){
    echo "num06"
}

fun_num07_datafile_info(){
    echo "num07"
}

fun_num08_tbs_info(){
    echo "num08"
}

fun_num09_os_info(){
    echo "num09"
}

fun_num10_tbiobench_info(){
    echo "num10"
}

fun_all_info(){
    fun_num01_license_info
    fun_num02_ncpu_info
    fun_num03_install_info
    fun_num04_profile_info
    fun_num05_cresql_info
    fun_num06_tip_info
    fun_num07_datafile_info
    fun_num08_tbs_info
    fun_num09_os_info
    fun_num10_tbiobench_info
}

echo "[*] tbis Installation Report" 
echo "-----------------------------------------------------------------"
echo "# 1. license.xml (tbboot -l)"
echo "# 2. ncpu (chk_cpu_for_license.sh tibero)"
echo "# 3. installation infomation"
echo "# 4. os user procfile"
echo "# 5. create database SQL Syntax"
echo "# 6. \$TB_HOME/config/\$TB_SID.tip"
echo "# 7. datafile infomation (tm 51)"
echo "# 8. tablespace infomation (tm 52)"
echo "# 9. uname / ulimit"
echo "# 10. tbiobench (-s 1G)"
echo "# all. all step"
echo "-----------------------------------------------------------------"
echo "b - before"
echo "press other key to quit"
echo "-----------------------------------------------------------------"
printf "Choose the Number : "
read input_number
case $input_number in
    1)
        fun_num01_license_info
        . fun/tbis_fun_common.sh press
        read wait_key
        . fun/tbis_fun_report.sh;;
    2)
        fun_num02_ncpu_info
        . fun/tbis_fun_common.sh press
        read wait_key
        . fun/tbis_fun_report.sh;;
    3)
        fun_num03_install_info
        . fun/tbis_fun_common.sh press
        read wait_key
        . fun/tbis_fun_report.sh;;
    4)
        fun_num04_profile_info
        . fun/tbis_fun_common.sh press
        read wait_key
        . fun/tbis_fun_report.sh;;
    5)
        fun_num05_cresql_info
        . fun/tbis_fun_common.sh press
        read wait_key
        . fun/tbis_fun_report.sh;;
    6)
        fun_num06_tip_info
        . fun/tbis_fun_common.sh press
        read wait_key
        . fun/tbis_fun_report.sh;;
    7)
        fun_num07_datafile_info
        . fun/tbis_fun_common.sh press
        read wait_key
        . fun/tbis_fun_report.sh;;
    8)
        fun_num09_os_info
        . fun/tbis_fun_common.sh press
        read wait_key
        . fun/tbis_fun_report.sh;;
    9)
        fun_num09_os_info
        . fun/tbis_fun_common.sh press
        read wait_key
        . fun/tbis_fun_report.sh;;
    10)
        fun_num10_tbiobench_info
        . fun/tbis_fun_common.sh press
        read wait_key
        . fun/tbis_fun_report.sh;;
    "all")
        file_time=`date +%F_%T |sed 's/://g' |sed 's/-//g'`
        fun_all_info |tee log/tbis_report_"$file_time".txt
        printf "Log file: "
        ls log/tbis_report_"$file_time".txt;;
    "b")
        $env_shell fun/tbis_fun_main.sh;;
    *)
        exit 1;;
esac