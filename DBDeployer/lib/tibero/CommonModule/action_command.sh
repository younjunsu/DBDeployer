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
	echo " - tar -xvf ../binary/tibero*.tar -C $TB_HOME"
	echo ""
	
    if [ "$step_key" == "YES" ] || [ "$all_auto_enable" == "Y" ]
    then
		gunzip $current_path/binary/tibero*.tar.gz
		tar -xvf $current_path/binary/tibero*.tar -C $user_home
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

    if [ "$step_key" == "YES" ] || [ "$all_auto_enable" == "Y" ]
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
	
		if [ "$step_key" == "YES" ] || [ "$all_auto_enable" == "Y" ]
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
	
	if [ "$step_key" == "YES" ] || [ "$all_auto_enable" == "Y" ]
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
    # 
    bootmode=$1
	
	echo ""
	echo "-----------------------------------------------------------------"
	echo " tbis Progress> tbboot"
	echo "-----------------------------------------------------------------"
	echo "  - install user : $run_user"
	echo "  - tibero  user : $user_name"
	echo "-----------------------------------------------------------------"
    
	if [ "$run_user_check" == "noswitch" ]
	then
		echo "  - tbboot $input_action"
	elif [ "$run_user_check" == "switch" ]
	then
		echo "  - su - $user_name -c \"tbboot $bootmode\""
	fi	
	echo "-----------------------------------------------------------------"
	echo ""
    

	if [ "$step_key" == "YES" ] || [ "$all_auto_enable" == "Y" ]
	then	
		case $bootmode in
			"nomount")
				if [ "$run_user_check" == "noswtich" ]
				then
					tbboot nomount
				elif [ "$run_user_check" == "switch" ]
				then
					su - $user_name -c "tbboot nomount"
				fi				
				;;
			"mount")
				if [ "$run_user_check" == "noswtich" ]
				then
					tbboot mount
				elif [ "$run_user_check" == "switch" ]
				then
					su - $user_name -c "tbboot mount"
				fi
				;;
			"normal")
				if [ "$run_user_check" == "noswtich" ]
				then
					tbboot normal
				elif [ "$run_user_check" == "switch" ]
				then
					su - $user_name -c "tbboot normal"
				fi
				;;
			"recovery")
				if [ "$run_user_check" == "noswtich" ]
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
    downmode=$1

	echo
	echo "-----------------------------------------------------------------"
	echo " Progress> tbdown"
	echo "-----------------------------------------------------------------"
	echo "  - install user : $tbis_run_user"
	echo "  - tibero  user : $user_name"
	echo "-----------------------------------------------------------------"
	if [ "$run_user_check" == "noswitch" ]
	then
		echo "  - tbdown $downmode"
	elif [ "$run_user_check" == "switch" ]
	then
		echo "  - su - $user_name -c \"tbdown $downmode\""
	fi
	echo "-----------------------------------------------------------------"
	echo ""


    if [ "$step_key" == "YES" ] || [ "$all_auto_enable" == "Y" ]
    then	
		case $downmode in
			"normal")
				if [ "$run_user_check" == "noswtich" ]
				then
					tbdown normal
				elif [ "$run_user_check" == "switch" ]
				then
					su - $user_name -c "tbdown normal"
				fi
				;;
			"immediate")
				if [ "$run_user_check" == "noswtich" ]
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
    bootmode=$1

}
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
function fn_tibero_cm_down(){
    downmode=$1
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

    if [ "$step_key" == "YES" ] || [ "$all_auto_enable" == "Y" ]
    then
		if [ "$run_user_check" == "noswtich" ]
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
		
    if [ "$step_key" == "YES" ] || [ "$all_auto_enable" == "Y" ]
    then
		if [ "$run_user_check" == "noswtich" ]
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


case $input_key in 
    "fn_engine")
        ;;
    "fn_license")
        ;;
    "fn_tbinary")
        ;;
    "fn_owner_change")
        ;;
    "fn_tibero_boot")
        ;;
    "fn_tibero_down")
        ;;
    "fn_tibero_cm_boot")
        ;;
    "fn_tibero_cm_down")
        ;;
    "fn_tibero_system_shell")
        ;;
    "fn_tibero_create_database")
        ;;
    *)
        ;;
esac