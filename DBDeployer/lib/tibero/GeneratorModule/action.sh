#
#--------------------------------------------------------------------------------
function fn_run_user_check(){
    if [ "$run_user" == "root" ] && [ "$user_name" == "root" ] || [ "$run_user" == "$user_name" ]
    then
        export run_user_check="noswitch"
    elif [ "$run_user" != "$user_name" ] && [ "$run_user" == "root" ] 
    then
        export run_user_check="switch"
    fi

}
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
function fn_engine(){
	echo ""
	echo "-----------------------------------------------------------------"
	echo " Progress> engine"
	echo "-----------------------------------------------------------------"
	echo ""
	echo " - gunzip ../binary/tibero*.tar.gz"
	echo " - tar -xvf ../binary/tibero*.tar -C $user_home"
	echo ""
	
	. $current_path/lib/tibero/GeneratorModule/common.sh fn_step_yesno

    if [ "$step_yesno" == "Y" ]
    then
		gunzip $current_path/binary/tibero*.tar.gz
		tar -xvf $current_path/binary/tibero*.tar --strip-components=1 -C $TB_HOME
    fi
}
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
function fn_license(){
    echo ""
    echo "-----------------------------------------------------------------"
    echo " Progress> license "    
    echo "-----------------------------------------------------------------"
    echo ""
    echo " - cp ../binary/license.xml $TB_HOME/license/license.xml"
    echo ""

	. $current_path/lib/tibero/GeneratorModule/common.sh fn_step_yesno

    if [ "$step_yesno" == "Y" ]
    then
        cp $current_path/binary/license.xml $TB_HOME/license/license.xml
    fi
}
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
function fn_tbinary(){
	if [ "$tibero_tbinary" == "Y" ]
	then
		echo ""
		echo "-----------------------------------------------------------------"
		echo " Progress> tbinary"
		echo "-----------------------------------------------------------------"
		echo ""
		echo " - tar -xvf ../binary/tbinary*.tar -C $user_home"
		echo ""

		. $current_path/lib/tibero/GeneratorModule/common.sh fn_step_yesno
	
		if [ "$step_yesno" == "Y" ]
		then
		 	tar -xvf $current_path/binary/tbinary*.tar -C $user_home	
		fi
	fi
}
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
function fn_owner_change(){
	echo ""
    echo "-----------------------------------------------------------------"
    echo " Progress> Change Owner"
    echo "-----------------------------------------------------------------"
	echo ""
	echo " - chown -R $user_name:$group_name $user_home"
	echo ""

	. $current_path/lib/tibero/GeneratorModule/common.sh fn_step_yesno
	
	if [ "$step_yesno" == "Y" ]
    then
		if [ "$run_user_check" == "switch" ]
		then
			chown -R $user_name:$group_name $user_home
			chown -R $user_name:$group_name $TB_HOME
		fi       
    fi
}
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
function fn_tibero_boot(){
	echo ""
	echo "-----------------------------------------------------------------"
	echo " tbis Progress> tbboot"
	echo "-----------------------------------------------------------------"
	echo "  - install user : $run_user"
	echo "  - tibero  user : $user_name"
	echo "-----------------------------------------------------------------"
    
	if [ "$run_user_check" == "noswitch" ]
	then
		echo "  - tbboot $action_option2"
	elif [ "$run_user_check" == "switch" ]
	then
		echo "  - su - $user_name -c \"tbboot $action_option2\""
	fi	
	echo "-----------------------------------------------------------------"
	echo ""

	. $current_path/lib/tibero/GeneratorModule/common.sh fn_step_yesno    

	if [ "$step_yesno" == "Y" ]
	then	
		case $action_option2 in
			"nomount")
				if [ "$run_user_check" == "noswitch" ]
				then
					tbboot nomount
				elif [ "$run_user_check" == "switch" ]
				then
					su - $user_name -c "tbboot nomount"
				fi				
				;;
			"mount")
				if [ "$run_user_check" == "noswitch" ]
				then
					tbboot mount
				elif [ "$run_user_check" == "switch" ]
				then
					su - $user_name -c "tbboot mount"
				fi
				;;
			"normal")
				if [ "$run_user_check" == "noswitch" ]
				then
					tbboot normal
				elif [ "$run_user_check" == "switch" ]
				then
					su - $user_name -c "tbboot normal"
				fi
				;;
			"recovery")
				if [ "$run_user_check" == "noswitch" ]
				then
					tbboot recovery
				elif [ "$run_user_check" == "switch" ]
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
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
function fn_tibero_down(){
	echo
	echo "-----------------------------------------------------------------"
	echo " Progress> tbdown"
	echo "-----------------------------------------------------------------"
	echo "  - install user : $run_user"
	echo "  - tibero  user : $user_name"
	echo "-----------------------------------------------------------------"
	if [ "$run_user_check" == "noswitch" ]
	then
		echo "  - tbdown $action_option2"
	elif [ "$run_user_check" == "switch" ]
	then
		echo "  - su - $user_name -c \"tbdown $action_option2\""
	fi
	echo "-----------------------------------------------------------------"
	echo ""

	. $current_path/lib/tibero/GeneratorModule/common.sh fn_step_yesno

    if [ "$step_yesno" == "Y" ]
    then	
		case $action_option2 in
			"normal")
				if [ "$run_user_check" == "noswitch" ]
				then
					tbdown normal
				elif [ "$run_user_check" == "switch" ]
				then
					su - $user_name -c "tbdown normal"
				fi
				;;
			"immediate")
				if [ "$run_user_check" == "noswitch" ]
				then
					tbdown immediate
				elif [ "$run_user_check" == "switch" ]
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
#--------------------------------------------------------------------------------



#
#--------------------------------------------------------------------------------
function fn_tibero_cm_boot(){
	echo ""
	echo "-----------------------------------------------------------------"
	echo " Progress> tbcm boot"
	echo "-----------------------------------------------------------------"
	echo "  - install user : $tbis_run_user"
	echo "  - tibero  user : $user_name"
	echo "  - tbcm -b"
	echo ""
    
	. $current_path/lib/tibero/GeneratorModule/common.sh fn_step_yesno
	
    if [ "$step_yesno" == "Y" ]
    then
		if [ "$run_user_check" == "noswtich" ]
		then
			tbcm -b
		elif [ "$run_user_check" == "switch" ]
		then
			su - $user_name -c "tbcm -b"
		fi
	fi

}
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
function fn_tibero_cm_down(){
	echo
	echo "-----------------------------------------------------------------"
	echo " tbis Progress> tbcm down"
	echo "-----------------------------------------------------------------"
	echo "  - install user : $tbis_run_user"
	echo "  - tibero  user : $user_name"
	echo "  - tbcm -d"
	echo ""

	. $current_path/lib/tibero/GeneratorModule/common.sh fn_step_yesno

    if [ "$step_yesno" == "Y" ]
    then
		if [ "$run_user_check" == "noswtich" ]
		then
			tbcm -d
		elif [ "$run_user_check" == "switch" ]
		then
			su - $user_name -c "tbcm -d"
		fi
	fi
}
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
function fn_tibero_system_shell(){
	echo ""
    echo "-----------------------------------------------------------------"
    echo " Progress> system.sh"
    echo "-----------------------------------------------------------------"
    echo ""
    echo "sh $TB_HOME/scripts/system.sh -p1 tibero -p2 syscat -a1 Y -a2 Y -a3 Y -a4 Y"
    echo ""

	. $current_path/lib/tibero/GeneratorModule/common.sh fn_step_yesno

    if [ "$step_yesno" == "Y" ]
    then
		if [ "$run_user_check" == "noswitch" ]
		then
			sh $TB_HOME/scripts/system.sh -p1 tibero -p2 syscat -a1 Y -a2 Y -a3 Y -a4 Y
		elif [ "$run_user_check" == "switch" ]
		then
			su - $user_name -c "sh $TB_HOME/scripts/system.sh -p1 tibero -p2 syscat -a1 Y -a2 Y -a3 Y -a4 Y"
		fi	
	fi
}
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
function fn_tibero_create_database(){
    echo ""
    echo "-----------------------------------------------------------------"
    echo " Progress> CREATE DATABASE"
    echo "-----------------------------------------------------------------"
	echo ""
	cat $current_path/config/tibero_credb.sql
	echo ""
		
	. $current_path/lib/tibero/GeneratorModule/common.sh fn_step_yesno		
	
    if [ "$step_yesno" == "Y" ]
    then
		if [ "$run_user_check" == "noswitch" ]
		then
			tbsql -s sys/tibero < $current_path/config/tibero_credb.sql
			echo ""
		elif [ "$run_user_check" == "switch" ]
		then
			su - $user_name -c "tbsql -s sys/tibero < $current_path/config/tibero_credb.sql"
			echo ""
		fi	
	fi
	sleep 1
}
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
function fn_tibero_tsc_filecopy(){
	echo ""
    echo "-----------------------------------------------------------------"
    echo " Progress> CREATE DATABASE"
    echo "-----------------------------------------------------------------"
	echo ""
	cat $current_path/config/tibero_credb.sql
	echo ""

	. $current_path/lib/tibero/GeneratorModule/common.sh fn_step_yesno	

    if [ "$step_yesno" == "Y" ]
    then
		if [ "$run_user_check" == "noswitch" ]
		then
			cp -pR  ${CONTROL_FILE_PATH1}/tbctl1 /share
			cp -pR  ${CONTROL_FILE_PATH2}/tbctl2 /share
			cp -pR  ${DB_CREATE_FILE_DEST}/tbdata /share
			cp -pR  ${LOG_ARCHIVE_DEST}/tbarch /share
			echo ""
		elif [ "$run_user_check" == "switch" ]
		then
			cp -pR  ${CONTROL_FILE_PATH1}/tbctl1 /share
			cp -pR  ${CONTROL_FILE_PATH2}/tbctl2 /share
			cp -pR  ${DB_CREATE_FILE_DEST}/tbdata /share
			cp -pR  ${LOG_ARCHIVE_DEST}/tbarch /share
			chown -R $user_name:$group_name /share/*
			echo ""
		fi	
	fi	
}
#--------------------------------------------------------------------------------

action_option1=$1
action_option2=$2

fn_run_user_check

case $action_option1 in 
    "fn_engine")
		fn_engine
        ;;
    "fn_license")
		fn_license
        ;;
    "fn_tbinary")
		fn_tbinary
        ;;
    "fn_owner_change")
		fn_owner_change
        ;;
    "fn_tibero_boot")
		fn_tibero_boot
        ;;
    "fn_tibero_down")
		fn_tibero_down
        ;;
    "fn_tibero_cm_boot")
		fn_tibero_cm_boot
        ;;
    "fn_tibero_cm_down")
		fn_tibero_cm_down
        ;;
    "fn_tibero_system_shell")
		fn_tibero_system_shell
        ;;
    "fn_tibero_create_database")
		fn_tibero_create_database
        ;;
	"fn_tibero_tsc_filecopy")
		fn_tibero_tsc_filecopy
		;;
esac