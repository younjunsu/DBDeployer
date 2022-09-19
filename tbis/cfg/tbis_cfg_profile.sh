# Do not change

############################################################
# user_home profile apply and output 
############################################################
fun_profile(){
    echo "#############################"
    echo "# TIBERO environment variable"
    echo "#############################"
    echo "#### SHELL"
    echo "stty erase ^H"
    echo "export PS1=[\\\\u\"@\"\\\\h\" \"\\\\W]\\$\" \""
    echo "export EDITOR=vim"
    echo ""
    echo "#### JAVA"
    echo "#export JAVA_HOME="
    echo ""
    if [ "$tibero_type" == "SINGLE" ]
    then
        echo "#### SINGLE"
        echo "export TB_SID=`echo $DB_NAME`"
        export TB_SID=`echo "$DB_NAME"`
        echo "export TB_HOME=$TB_HOME"
    elif [ "$tibero_type" == "TSC" ]
    then
        echo "#### TSC (Tibero Standby Cluster)"
        if [ "$tibero_node" == "primary" ]
        then
            echo "export TB_SID=`echo $DB_NAME`_p"
            export TB_SID=`echo "$DB_NAME"_p`
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=primary"
            echo "export CM_HOME=\$TB_HOME"
        elif [ "$tibero_node" == "standby" ]
        then
            echo "export TB_SID=`echo $DB_NAME`_s"
            export TB_SID=`echo "$DB_NAME"_s`
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=standby"
            echo "export CM_HOME=\$TB_HOME"
        elif [ "$tibero_node" == "observer" ]
        then
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=observer"
            echo "export CM_HOME=\$TB_HOME"
        fi
    elif [ "$tibero_type" == "TAC" ]
    then
        echo "#### TAC (Tibero Active Cluster)"
        if [ "$tibero_node" == "cm0" ]
        then
            echo "export TB_SID=`echo $DB_NAME`0"
            export TB_SID=`echo "$DB_NAME"0`
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=cm0"
            echo "export CM_HOME=\$TB_HOME"
        elif [ "$tibero_node" == "cm1" ]
        then
            echo "export TB_SID=`echo $DB_NAME`1"
            export TB_SID=`echo "$DB_NAME"1`
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=cm1"
            echo "export CM_HOME=\$TB_HOME"
        fi
    fi
    echo ""
    echo "### TIBERO"
    echo "export TB_PROF_DIR=\$TB_HOME/bin/prof"
    echo "export LD_LIBRARY_PATH=\$TB_HOME/lib:\$TB_HOME/client/lib"
    echo "export LIBPATH=\$LD_LIBRARY_PATH"
    echo "export SHLIB_PATH=\$LD_LIBRARY_PATH"
    echo "export PATH=\$PATH:\$TB_HOME/bin:\$TB_HOME/client/bin:\$JAVA_HOME/bin"
    echo ""
    echo "#### TIBERO Alias"
    echo "alias tbhome='cd \$TB_HOME'"
    echo "alias tbbin='cd \$TB_HOME/bin'"
    echo "alias tblog='cd \$TB_HOME/instance/\$TB_SID/log'"
    echo "alias tbcfg='cd \$TB_HOME/config'"
    echo "alias tbcfgv='vi \$TB_HOME/config/\$TB_SID.tip'"
    echo "alias tbcli='cd \$TB_HOME/client/config'"
    echo "alias tbcliv='vi \$TB_HOME/client/config/tbdsn.tbr'"
    echo "alias tm='\$HOME/tbinary/monitor/monitor'"
    echo "alias tbi='cd \$HOME/tbinary'"
}


# user_name profile file check
profile_bashprofile_chk=$user_home/.bash_profile
profile_profile_chk=$user_home/.profile

if [ -f "$profile_profile_chk" ]
then
    export profile_path=$profile_profile_chk
elif [ -f "$profile_bashprofile_chk" ]
then
    export profile_path=$profile_bashprofile_chk
fi


# profile mode check
# apply: create profile file
# output: display output
cfg_profile_mode=$1

if [ -z $"cfg_profile_mode" ]
then
    2>/dev/null
elif [ "$cfg_profile_mode" == "apply" ]
then
    echo
    echo "############################################################"
    echo "# tbis Progress> Profile " 
    echo "############################################################"
    echo
    echo " $profile_path apply configuration"
    echo
    $tbis_current_path/fun/tbis_fun_common.sh progress_chk
    if [ "$progress_yesno" == "YES" ]
    then
        fun_profile >> $profile_path
    fi
elif [ "$cfg_profile_mode" == "output" ]
then
    fun_profile
fi


############################################################
# root cm profile apply and output 
############################################################
# root cm profile function
fun_root_cm_profile(){
if [ "$tibero_type" != "SINGLE" ]
then
    echo "#############################"
    echo "# TIBERO CM environment variable"
    echo "#############################"
    if [ "$tibero_type" == "TSC" ]
    then
        echo "#### TSC (Tibero Standby Cluster)"
        if [ "$tibero_node" == "primary" ]
        then
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=primary"
            echo "export CM_HOME=\$TB_HOME"
        elif [ "$tibero_node" == "standby" ]
        then
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=standby"
            echo "export CM_HOME=\$TB_HOME"
        fi
    elif [ "$tibero_type" == "TAC" ]
    then
        echo "#### TAC (Tibero Active Cluster)"
        if [ "$tibero_node" == "cm0" ]
        then
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=cm0"
            echo "export CM_HOME=\$TB_HOME"
        elif [ "$tibero_node" == "cm1" ]
        then
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=cm1"
            echo "export CM_HOME=\$TB_HOME"
        fi
    fi
fi
echo ""
echo "### TIBERO"
echo "export TB_PROF_DIR=\$TB_HOME/bin/prof"
echo "export LD_LIBRARY_PATH=\$TB_HOME/lib:\$TB_HOME/client/lib"
echo "export LIBPATH=\$LD_LIBRARY_PATH"
echo "export SHLIB_PATH=\$LD_LIBRARY_PATH"
echo "export PATH=\$PATH:\$TB_HOME/bin:\$TB_HOME/client/bin:\$JAVA_HOME/bin"    
}


# root profile file check
root_profile_bashprofile_chk=/root/.bash_profile
root_profile_profile_chk=/root/.profile

if [ -f "$root_profile_profile_chk" ]
then
    root_profile_path=$profile_profile_chk
elif [ -f "$root_profile_bashprofile_chk" ]
then
    root_profile_path=$root_profile_bashprofile_chk
fi


# root_cm_profile enable check
if [ "$root_cm_profile" == "Y" ]
then
    # profile mode check
    # apply: create profile file
    # output: display output
    if [ -z $"cfg_profile_mode" ]
    then
        2>/dev/null
    elif [ "$cfg_profile_mode" == "apply" ]
    then
        fun_root_cm_profile >> $root_profile_path
    elif [ "$cfg_profile_mode" == "output" ]
    then
        fun_root_cm_profile
    fi
else
    2>/dev//null
fi