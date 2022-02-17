#!/bin/sh

############################################################
#
# Program variables
############################################################
# Initialization
#export FN_PROFILE_RESULT_FILE="./tb_files/TIBERO_PROFILE_RESULT.txt"
#echo "" > $FN_PROFILE_RESULT_FILE

# Functions Parameters
INPUT_INI_FILE=$1
INPUT_TIBERO_TYPE=$2
INPUT_TB_HOME=$3
INPUT_TB_SID=$4
INPUT_DB_NAME=$5
INPUT_CM_SID=$6


############################# Profile
FN_BASE_PROFILE(){
    echo "#############################"
    echo "# TIBERO environment variable"
    echo "#############################"
    echo "#### SHELL"
    echo "stty erase ^H"
    echo "export PS1="[\`whoami\`@\`hostname\`:\$PWD]\$ ""
    echo "export EDITOR=vim"
    echo ""
    echo "#### JAVA"
    echo "#export JAVA_HOME="
    echo ""
    echo "#### SINGLE"
    echo "export TB_SID=$INPUT_TB_SID"
    echo "export TB_HOME=$INPUT_TB_HOME"
    echo "export TB_PROF_DIR=\$TB_HOME/bin/prof"
    echo "export LD_LIBRARY_PATH=\$TB_HOME/lib:$TB_HOME/client/lib"
    echo "export LIBPATH=\$LD_LIBRARY_PATH"
    echo "export SHLIB_PATH=\$LD_LIBRARY_PATH"
    echo "export PATH\$PATH:\$TB_HOME/bin:\$TB_HOME/client/bin:\$JAVA_HOME/bin"
    echo ""
    echo ""
    FN_TIBERO_ALIAS
}



FN_TSC_PROFILE(){
    echo "#############################"
    echo "# TIBERO environment variable"
    echo "#############################"
    echo "#### SHELL"
    echo "stty erase ^H"
    echo "export PS1="[\`whoami\`@\`hostname\`:\$PWD\]$""
    echo "export EDITOR=vim"
    echo ""
    echo "#### JAVA"
    echo "#export JAVA_HOME="
    echo ""
    echo "#### TSC (Tibero Standby Cluster)"
    echo "export TB_SID=$INPUT_TB_SID"
    echo "export CM_SID=$INPUT_CM_SID"
    echo ""
    echo "export TB_HOME=$INPUT_TB_HOME"
    echo "export CM_HOME=\$TB_HOME"
    echo "export TB_PROF_DIR=\$TB_HOME/bin/prof"
    echo "export LD_LIBRARY_PATH=\$TB_HOME/lib:\$TB_HOME/client/lib"
    echo "export LIBPATH=\$LD_LIBRARY_PATH"
    echo "export SHLIB_PATH=\$LD_LIBRARY_PATH"
    echo "export PATH=\$PATH:\$TB_HOME/bin:\$TB_HOME/client/bin:\$JAVA_HOME/bin"
    echo ""
    echo ""
    FN_TIBERO_ALIAS
}

FN_TAC_PROFILE(){
    #############################
    # TIBERO environment variable
    #############################
    #### SHELL
    stty erase ^H
    export PS1="[`whoami`@`hostname`:\$PWD]$ "
    export EDITOR=vim

    #### JAVA
    # 설치 시 필수로 확인.
    #export JAVA_HOME=

    #### TAC (Tibero Active Cluster)
    ## TAC
    #export TB_SID=<DB_NAME>0
    #export TB_SID=<DB_NAME>1
    #export CM_SID=cm0
    #export CM_SID=cm1
    #export CM_HOME=$TB_HOME

    export TB_HOME=
    export TB_PROF_DIR=$TB_HOME/bin/prof
    export LD_LIBRARY_PATH=$TB_HOME/lib:$TB_HOME/client/lib
    export LIBPATH=$LD_LIBRARY_PATH
    export SHLIB_PATH=$LD_LIBRARY_PATH
    export PATH=$PATH:$TB_HOME/bin:$TB_HOME/client/bin:$JAVA_HOME/bin

}

FN_TIBERO_ALIAS(){

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


############################# TB_SID.tip
BASE_TB_TIP(){
    ############ TIBERO genernal
    #### Must
    DB_NAME=
    LISTENER_PORT=8629
    CONTROL_FILES=tbctl1/c1.ctl, tbctl2/c2.ctl
    DB_CREATE_FILE_DEST=tbdata/*
    LOG_ARCHIVE_DEST=tbarch/*
    MAX_SESSION_COUNT=
    TOTAL_SHM_SIZE=
    MEMORY_TARGET=

    ############ TFT Parameters
    #### Must
    USE_TS_QUOTA=N
    AUTHENTICATION_TIMEOUT=100
    DBLINK_CONN_TIMEOUT=100
    TPR_SNAPSHOT_RETENTION=30
    TPR_SNAPSHOT_TOP_SQL_CNT=10
    GATHER_SQL_EXEC_TIME=Y
    GATHER_SQL_PLAN_STAT=Y
    SLOG_TOTAL_SIZE_LIMIT=1G
    _SLOG_DISPLAY_YEAR=Y
    AUDIT_SYS_OPERATIONS=Y
    AUDIT_TRAIL=OS

    #### Recommand
    #BOOT_WITH_AUTO_DOWN_CLEAN=Y
    #USE_RECYCLEBIN=Y
    #LOG_DEFAULT_DEST=
    #ACT_LOG_DEST=
    #CALLSTACK_DUMP_DEST=
    ## IMS224485 - 2022.01.27
    #_STANDBY_NETWORK_TIMEOUT=90    
}

TSC_TB_TIP(){
    ############ TSC (Tibero Standby Cluster)
    #### Must
    CM_PORT=28629
    STANDBY_USE_OBSERVER=Y
    LOG_REPLICATION_MODE=PERFORMANCE
    LOCAL_CLUSTER_PORT=18629

    ## Primary
    #LOG_REPLICATION_DEST_1="<Standby IP>:8633 LGWR ASYNC"
    #LOCAL_CLUSTER_ADDR=<Primary IP>

    ## Standny
    #LOG_REPLICATION_DEST_1="<Primary IP>:8633 LGWR ASYNC"
    #LOCAL_CLUSTER_ADDR=<Standby IP>
}

TAC_TB_TIP(){
    ############ TAC (Tibero Active Cluster)
    #### Must
    CLUSTER_DATABASE=Y
    _USE_O_DIRECT=Y

    ## cm0
    #THREAD=0
    #UNDO_TABLESPACE=UNDO0
    #CM_NAME=cm0
    #CM_PORT=28629
    #LOCAL_CLUSTER_ADDR=<localhost IP>
    #LOCAL_CLUSTER_PORT=18629

    ## cm1
    #THREAD=1
    #UNDO_TABLESPACE=UNDO1
    #CM_NAME=cm1
    #CM_PORT=28629
    #LOCAL_CLUSTER_ADDR=<localhost IP>
    #LOCAL_CLUSTER_PORT=18629
}

############################# CM_SID.tip
TSC_CM_TIP(){
    ############ TSC (Tibero Standby Cluster)
    #### Must
    #CM_HEARTBEAT_EXPIRE=300
    #CM_WATCHDOG_EXPIRE=290

    ## Primary
    #CM_NAME=primary
    #CM_UI_PORT=28629
    #CM_RESOURCE_FILE=<TB_HOME>/config/primary_res_file
    ## Standby
    #CM_NAME=standby
    #CM_UI_PORT=28629
    #CM_RESOURCE_FILE=<TB_HOME>/config/standby_res_file
    ## Observer
    #CM_NAME=observer
    #CM_UI_PORT=38629
    #CM_OBSERVER_PORT=9050
    #CM_MODE_OBSERVER=Y
    #### Recommand
    #CM_ENABLE_FAST_NET_ERROR_DETECTION=Y
    echo
}

TAC_CM_TIP(){
    ############ TAC (Tibero Active Cluster)
    #### Must
    ## cm0
    #CM_NAME=cm0
    #CM_UI_PORT=28629
    #CM_RESOURCE_FILE=<TB_HOME>/config/cm0_res_file
    ## cm1
    #CM_NAME=cm1
    #CM_UI_PORT=28629
    #CM_RESOURCE_FILE=<TB_HOME>/config/cm1_res_file

    #### Recommand
    #CM_HEARTBEAT_EXPIRE=300
    #CM_WATCHDOG_EXPIRE=290
    #CM_ENABLE_FAST_NET_ERROR_DETECTION=Y
    echo
}

if [ $INPUT_INI_FILE == "PROFILE" ] && [ $INPUT_TIBERO_TYPE == "1" ] && [ -n $INPUT_TB_HOME ] && [ -n $INPUT_TB_SID ]
then
    # SINGLE
    FN_BASE_PROFILE
elif [ $INPUT_INI_FILE == "PROFILE" ] && [ $INPUT_TIBERO_TYPE == "2" ] && [ -n $INPUT_TB_HOME ] && [ -n $INPUT_TB_SID ]
then
    # TSC
    FN_TSC_PROFILE
elif [ $INPUT_INI_FILE == "PROFILE" ] && [ $INPUT_TIBERO_TYPE == "3" ] && [ -n $INPUT_TB_HOME ] && [ -n $INPUT_TB_SID ]
then
    # TAC
    echo
elif [ $INPUT_INI_FILE == "PROFILE" ] && [ $INPUT_TIBERO_TYPE == "4" ] && [ -n $INPUT_TB_HOME ] && [ -n $INPUT_TB_SID ]
then
    # TAS
    echo
else
    echo
    exit 0
fi