# Do not change

# PROFILE
fun_profile_output(){
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
    if [ "$TIBERO_TYPE" == "SINGLE" ]
    then
        echo "#### SINGLE"
        echo "export TB_SID=`echo $DB_NAME`"
        echo "export TB_HOME=$TB_HOME"
    elif [ "$TIBERO_TYPE" == "TSC" ]
    then
        echo "#### TSC (Tibero Standby Cluster)"
        if [ "$TIBERO_NODE" == "primary" ]
        then
            echo "export TB_SID=`echo $DB_NAME`_p"
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=primary"
            echo "export CM_HOME=\$TB_HOME"
        elif [ "$TIBERO_NODE" == "standby" ]
        then
            echo "export TB_SID=`echo $DB_NAME`_s"
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=standby"
            echo "export  =\$TB_HOME"
        elif [ "$TIBERO_NODE" == "observer" ]
        then
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=observer"
            echo "export CM_HOME=\$TB_HOME"
        else
            2>/dev/null
        fi
    elif [ "$TIBERO_TYPE" == "TAC" ]
    then
        echo "#### TAC (Tibero Active Cluster)"
        if [ "$TIBERO_NODE" == "cm0" ]
        then
            echo "export TB_SID=`echo $DB_NAME`0"
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=cm0"
            echo "export CM_HOME=\$TB_HOME"
        elif [ "$TIBERO_NODE" == "cm1" ]
        then
            echo "export TB_SID=`echo $DB_NAME`1"
            echo "export TB_HOME=$TB_HOME"
            echo "export CM_SID=cm1"
            echo "export CM_HOME=\$TB_HOME"
        else
            2>dev/null
        fi
    fi
    echo ""
    echo "### General"
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