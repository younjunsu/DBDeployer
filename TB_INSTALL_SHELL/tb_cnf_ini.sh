#!/bin/sh

############################################################
#
# Program variables
############################################################
# Initialization
export FN_PROFILE_RESULT_FILE="./tb_files/TIBERO_PROFILE_RESULT.txt"
echo "" > $FN_PROFILE_RESULT_FILE

# Functions Parameters
INI_TYPE=$1
TB_TPYE=$2
TB_ENGPATH=$3
TB_DBNAME=$4
TB_CMNAME=$5


############################# Profile
function FN_BASE_PROFILE(){
    echo "" > $FN_PROFILE_RESULT_FILE
    echo "#############################" >> $FN_PROFILE_RESULT_FILE
    echo "# TIBERO environment variable" >> $FN_PROFILE_RESULT_FILE
    echo "#############################" >> $FN_PROFILE_RESULT_FILE
    echo "#### SHELL" >> $FN_PROFILE_RESULT_FILE
    echo "stty erase ^H" >> $FN_PROFILE_RESULT_FILE
    echo "export PS1="[\`whoami\`@\`hostname\`:\$PWD]\$ "" >> $FN_PROFILE_RESULT_FILE
    echo "export EDITOR=vim" >> $FN_PROFILE_RESULT_FILE
    echo "" >> $FN_PROFILE_RESULT_FILE
    echo "#### JAVA" >> $FN_PROFILE_RESULT_FILE
    echo "#export JAVA_HOME=" >> $FN_PROFILE_RESULT_FILE
    echo "" >> $FN_PROFILE_RESULT_FILE
    echo "#### SINGLE" >> $FN_PROFILE_RESULT_FILE
    echo "export TB_SID=$TB_DBNAME" >> $FN_PROFILE_RESULT_FILE
    echo "export TB_HOME=" >> $FN_PROFILE_RESULT_FILE
    echo "export TB_PROF_DIR=\$TB_HOME/bin/prof" >> $FN_PROFILE_RESULT_FILE
    echo "export LD_LIBRARY_PATH=\$TB_HOME/lib:$TB_HOME/client/lib" >> $FN_PROFILE_RESULT_FILE
    echo "export LIBPATH=\$LD_LIBRARY_PATH" >> $FN_PROFILE_RESULT_FILE
    echo "export SHLIB_PATH=\$LD_LIBRARY_PATH" >> $FN_PROFILE_RESULT_FILE
    echo "export PATH\$PATH:\$TB_HOME/bin:\$TB_HOME/client/bin:\$JAVA_HOME/bin" >> $FN_PROFILE_RESULT_FILE
    echo "" >> $FN_PROFILE_RESULT_FILE
}

function FN_TSC_PROFILE(){
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

    #### TSC (Tibero Standby Cluster)
    export TB_SID=
    ## TSC
    #export TB_SID=<DB_NAME>_p
    #export TB_SID=<DB_NAME>_s
    #export CM_SID=primary
    #export CM_SID=standby
    #export CM_SID=observer
    #export CM_HOME=$TB_HOME

    export TB_HOME=
    export TB_PROF_DIR=$TB_HOME/bin/prof
    export LD_LIBRARY_PATH=$TB_HOME/lib:$TB_HOME/client/lib
    export LIBPATH=$LD_LIBRARY_PATH
    export SHLIB_PATH=$LD_LIBRARY_PATH
    export PATH=$PATH:$TB_HOME/bin:$TB_HOME/client/bin:$JAVA_HOME/bin

    #### TIBERO alias
    alias tbhome='cd $TB_HOME'
    alias tbbin='cd $TB_HOME/bin'
    alias tblog='cd $TB_HOME/instance/$TB_SID/log'
    alias tbcfg='cd $TB_HOME/config'
    alias tbcfgv='vi $TB_HOME/config/$TB_SID.tip'
    alias tbcli='cd $TB_HOME/client/config'
    alias tbcliv='vi $TB_HOME/client/config/tbdsn.tbr'
    alias tm='$HOME/tbinary/monitor/monitor'
    alias tbi='cd $HOME/tbinary'
}

function FN_TAC_PROFILE(){
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


    #### TIBERO alias
    alias tbhome='cd $TB_HOME'
    alias tbbin='cd $TB_HOME/bin'
    alias tblog='cd $TB_HOME/instance/$TB_SID/log'
    alias tbcfg='cd $TB_HOME/config'
    alias tbcfgv='vi $TB_HOME/config/$TB_SID.tip'
    alias tbcli='cd $TB_HOME/client/config'
    alias tbcliv='vi $TB_HOME/client/config/tbdsn.tbr'
    alias tm='$HOME/tbinary/monitor/monitor'
    alias tbi='cd $HOME/tbinary'
}

function FN_PROSYNC_PROFILE(){
    echo
}

function FN_TAS_PROFILE(){
    echo
}

############################# TB_SID.tip
function BASE_TB_TIP(){
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

function TSC_TB_TIP(){
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

function TAC_TB_TIP(){
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
function TSC_CM_TIP(){
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

function TAC_CM_TIP(){
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




if [ $INI_TYPE == "PROFILE" ] && [ $TB_TPYE == "1" ] && [ -n $TB_ENGPATH ] && [ -n $TB_DBNAME ] && [ -n $TB_CMNAME ]
then
    # SINGLE
    FN_BASE_PROFILE
elif [ $INI_TYPE == "PROFILE1" ]
then
    # TSC
    echo
elif [ $INI_TYPE == "PROFILE2" ]
then
    # TSC
    echo
elif [ $INI_TYPE == "PROFILE3" ]
then
    # TAC
    echo
else
    echo
    exit 0
fi