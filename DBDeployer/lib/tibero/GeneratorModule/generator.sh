#
#--------------------------------------------------------------------------------
function fn_profile(){
    . $current_path/lib/tibero/GeneratorModule/config/profile.sh
}
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
function fn_instance_tip(){
    . $current_path/lib/tibero/GeneratorModule/config/instance_tip.sh
}
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
function fn_tbdsn(){
    . $current_path/lib/tibero/GeneratorModule/config/tbdsn_tbr.sh
}
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
function fn_cm_tip(){
    . $current_path/lib/tibero/GeneratorModule/config/cm_tip.sh
}
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
function fn_cm_resource(){
    . $current_path/lib/tibero/GeneratorModule/config/cm_resource.sh
}
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
function fn_cm_resource_command(){
    . $current_path/lib/tibero/GeneratorModule/config/cm_resource_command.sh
}
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
export profile_path=$user_home/.bash_profile
generator_option1=$1
generator_option2=$2

case $generator_option1 in
    "fn_profile")
        if [ "$generator_option2" == "apply" ]
        then
            echo "-----------------------------------------------------------------"
            echo " Progress> Profile "
            echo "-----------------------------------------------------------------"
            echo ""
            echo "  - $profile_path apply configuration"
            echo ""
            
            . $current_path/lib/tibero/GeneratorModule/common.sh fn_step_yesno

            if [ "$step_yesno" == "Y" ]
            then
                fn_profile >> $profile_path
            fi

        elif [ "$generator_option2" == "output" ]
        then
            fn_profile
        fi
        ;;
    "fn_instance_tip")
        if [ "$generator_option2" == "apply" ]
        then
            echo
            echo "-----------------------------------------------------------------"
            echo " Progress> TB_SID TIP File"
            echo "-----------------------------------------------------------------"
            echo ""
            echo "  - $TB_SID.tip $TB_HOME/config/$TB_SID.tip apply configuration"
            echo ""       
            
            . $current_path/lib/tibero/GeneratorModule/common.sh fn_step_yesno

            if [ "$step_yesno" == "Y" ]
            then            
                fn_instance_tip > "$TB_HOME"/config/"$TB_SID".tip
            fi

        elif [ "$generator_option2" == "output" ]
        then
            fn_instance_tip
        fi
        ;;
    "fn_tbdsn")
        if [ "$generator_option2" == "apply" ]
        then
            echo
            echo "-----------------------------------------------------------------"
            echo " Progress> TBDSN"
            echo "-----------------------------------------------------------------"
            echo ""
            echo "- tbdsn.tbr: $TB_HOME/client/config/tbdsn.tbr"
            echo ""
            
            . $current_path/lib/tibero/GeneratorModule/common.sh fn_step_yesno

            if [ "$step_yesno" == "Y" ]
            then            
                fn_tbdsn > "$TB_HOME"/client/config/tbdsn.tbr
            fi

        elif [ "$generator_option2" == "output" ]
        then
            fn_tbdsn
        fi    
        ;;        
    "fn_cm_tip")
        if [ "$generator_option2" == "apply" ]
        then
            echo
            echo "-----------------------------------------------------------------"
            echo " Progress> CM_SID TIP File"
            echo "-----------------------------------------------------------------"
            echo ""
            echo "  - $CM_SID.tip $TB_HOME/config/$CM_SID.tip apply configuration"
            echo ""
                        
            . $current_path/lib/tibero/GeneratorModule/common.sh fn_step_yesno

            if [ "$step_yesno" == "Y" ]
            then
                fn_cm_tip > "$TB_HOME"/config/"$CM_SID".tip
            fi

        elif [ "$generator_option2" == "output" ]
        then
            fn_cm_tip
        fi    
        ;;
    "fn_cm_resource")
        if [ "$generator_option2" == "apply" ]
        then
            echo
            echo "-----------------------------------------------------------------"
            echo " Progress> CM Resource"
            echo "-----------------------------------------------------------------"
            echo ""
            fn_cm_resource
            echo ""

            . $current_path/lib/tibero/GeneratorModule/common.sh fn_step_yesno

            if [ "$step_yesno" == "Y" ]
            then       
                fn_cm_resource_command
            fi
            
        elif [ "$generator_option2" == "output" ]
        then
            fn_cm_resource
        fi       
        ;;
esac
#--------------------------------------------------------------------------------