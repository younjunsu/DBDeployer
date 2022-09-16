# chk
# cfg
# param

############################################################
# env
############################################################
. $tbis_current_path/tbis.cfg

############################################################
# file configuration check
############################################################
fun_file_error(){
  # init
  param_error_file="N"

  # check param

  chk_engine_file=`ls ../binary/tibero*.tar* 2>/dev/null`
  if [ -z "$chk_engine_file" ]
  then
    echo "  error> tibero engine file unknown"
    param_error_file="Y"
  fi

  chk_license_file=`ls ../binary/license.xml 2>/dev/null`
  if [ -z "$chk_license_file" ]
  then
    echo "  error> tibero license file unknown"
    param_error_file="Y"

  fi


  # TIBERO configuration directory check
  if [ "$tbis_run_user" == "root" ] && [ "$user_name" == "root" ] || [ "$tbis_run_user" != "root" ]
  then
    # TB_HOME permission check
    if [ -z "$TB_HOME" ]
    then
      echo "  error> tbis_cfg.main : TB_HOME"
      param_error_file="Y"
    else
      chk_move_path=`cd $TB_HOME 2>&1`

      if [ -z "$chk_move_path" ]
      then
        cd $TB_HOME
        cd ../

        chk_cfg_path=`echo $TB_HOME |awk -F/ '{print $NF}'`
        chk_db_read_dir=`ls -l |grep $chk_cfg_path |awk '{print $1}' |cut -c "2,3,4" |grep "r"`
        chk_db_write_dir=`ls -l |grep $chk_cfg_path |awk '{print $1}' |cut -c "2,3,4" |grep "w"`
        
        if [ -z "$chk_db_read_dir" ]
        then
          echo "  error> TB_HOME : $TB_HOME read permission denied"
          param_error_file="Y"
        fi

        if [ -z "$chk_db_write_dir" ]
        then
          echo "  error> TB_HOME : $TB_HOME write permission denied"
          param_error_file="Y"
        fi

      elif [ -n "$chk_move_path" ]
      then
        echo "  error> TB_HOME : $TB_HOME execute permission denied"
        param_error_file="Y"  
      fi
    fi

    # CONTROL_FILE_PATH1 permission check
    if [ -z "$CONTROL_FILE_PATH1" ]
    then
      echo "  error>  tbis.cfg : CONTROL_FILE_PATH1"
      param_error_file="Y"
    else
      chk_move_path=`cd $CONTROL_FILE_PATH1 2>&1`

      if [ -z "$chk_move_path" ]
      then
        cd $CONTROL_FILE_PATH1
        cd ../

        chk_cfg_path=`echo $CONTROL_FILE_PATH1 |awk -F/ '{print $NF}'`
        chk_db_read_dir=`ls -l |grep $chk_cfg_path |awk '{print $1}' |cut -c "2,3,4" |grep "r"`
        chk_db_write_dir=`ls -l |grep $chk_cfg_path |awk '{print $1}' |cut -c "2,3,4" |grep "w"`
        
        if [ -z "$chk_db_read_dir" ]
        then
          echo "  error> CONTROL_FILE_PATH1 : $CONTROL_FILE_PATH1 read permission denied"
          param_error_file="Y"
        fi

        if [ -z "$chk_db_write_dir" ]
        then
          echo "  error> CONTROL_FILE_PATH1 : $CONTROL_FILE_PATH1 write permission denied"
          param_error_file="Y"
        fi

      elif [ -n "$chk_move_path" ]
      then
        echo "  error> CONTROL_FILE_PATH1 : $CONTROL_FILE_PATH1 execute permission denied"
        param_error_file="Y"  
      fi
    fi

    # CONTROL_FILE_PATH2 permission check
    if [ -z "$CONTROL_FILE_PATH2" ]
    then
      echo "  error> tbis.cfg : CONTROL_FILE_PATH2"
      param_error_file="Y"
    else
      chk_move_path=`cd $CONTROL_FILE_PATH2 2>&1`

      if [ -z "$chk_move_path" ]
      then
        cd $CONTROL_FILE_PATH2
        cd ../

        chk_cfg_path=`echo $CONTROL_FILE_PATH2 |awk -F/ '{print $NF}'`
        chk_db_read_dir=`ls -l |grep $chk_cfg_path |awk '{print $1}' |cut -c "2,3,4" |grep "r"`
        chk_db_write_dir=`ls -l |grep $chk_cfg_path |awk '{print $1}' |cut -c "2,3,4" |grep "w"`
        
        if [ -z "$chk_db_read_dir" ]
        then
          echo "  error> CONTROL_FILE_PATH2 : $CONTROL_FILE_PATH2 read permission denied"
          param_error_file="Y"
        fi

        if [ -z "$chk_db_write_dir" ]
        then
          echo "  error> CONTROL_FILE_PATH2 : $CONTROL_FILE_PATH2 write permission denied"
          param_error_file="Y"
        fi

      elif [ -n "$chk_move_path" ]
      then
        echo "  error> CONTROL_FILE_PATH2 : $CONTROL_FILE_PATH2 execute permission denied"
        param_error_file="Y"  
      fi
    fi

    # DB_CREATE_FILE_DEST permission check
    if [ -z "$DB_CREATE_FILE_DEST" ]
    then
      echo "  error> tbis.cfg : DB_CREATE_FILE_DEST"
      param_error_file="Y"
    else
      chk_move_path=`cd $DB_CREATE_FILE_DEST 2>&1`

      if [ -z "$chk_move_path" ]
      then
        cd $DB_CREATE_FILE_DEST
        cd ../

        chk_cfg_path=`echo $DB_CREATE_FILE_DEST |awk -F/ '{print $NF}'`
        chk_db_read_dir=`ls -l |grep $chk_cfg_path |awk '{print $1}' |cut -c "2,3,4" |grep "r"`
        chk_db_write_dir=`ls -l |grep $chk_cfg_path |awk '{print $1}' |cut -c "2,3,4" |grep "w"`
        
        if [ -z "$chk_db_read_dir" ]
        then
          echo "  error> DB_CREATE_FILE_DEST : $DB_CREATE_FILE_DEST read permission denied"
          param_error_file="Y"
        fi

        if [ -z "$chk_db_write_dir" ]
        then
          echo "  error> DB_CREATE_FILE_DEST : $DB_CREATE_FILE_DEST write permission denied"
          param_error_file="Y"
        fi

      elif [ -n "$chk_move_path" ]
      then
        echo "  error> DB_CREATE_FILE_DEST : $DB_CREATE_FILE_DEST execute permission denied"
        param_error_file="Y"  
      fi
    fi

    # LOG_ARCHIVE_DEST permission check
    if [ -z "$LOG_ARCHIVE_DEST" ]
    then
      echo "  error> tbis.cfg : LOG_ARCHIVE_DEST"
      param_error_file="Y"
    else
      chk_move_path=`cd $LOG_ARCHIVE_DEST 2>&1`

      if [ -z "$chk_move_path" ]
      then
        cd $LOG_ARCHIVE_DEST
        cd ../

        chk_cfg_path=`echo $LOG_ARCHIVE_DEST |awk -F/ '{print $NF}'`
        chk_db_read_dir=`ls -l |grep $chk_cfg_path |awk '{print $1}' |cut -c "2,3,4" |grep "r"`
        chk_db_write_dir=`ls -l |grep $chk_cfg_path |awk '{print $1}' |cut -c "2,3,4" |grep "w"`
        
        if [ -z "$chk_db_read_dir" ]
        then
          echo "  error> LOG_ARCHIVE_DEST : $LOG_ARCHIVE_DEST read permission denied"
          param_error_file="Y"
        fi

        if [ -z "$chk_db_write_dir" ]
        then
          echo "  error> LOG_ARCHIVE_DEST : $LOG_ARCHIVE_DEST write permission denied"
          param_error_file="Y"
        fi

      elif [ -n "$chk_move_path" ]
      then
        echo "  error> LOG_ARCHIVE_DEST : $LOG_ARCHIVE_DEST execute permission denied"
        param_error_file="Y"  
      fi
    fi

    # cfile_path permission check
    if [ "$tibero_type" == "TSC" ] || [ "$tibero_type" == "TAC" ]
    then
      if [ -z "$cfile_path" ]
      then
        echo "  error> tbis.cfg : cfile_path"
        param_error_file="Y"
      else
        chk_move_path=`cd $cfile_path 2>&1`

        if [ -z "$chk_move_path" ]
        then
          cd $cfile_path
          cd ../

          chk_cfg_path=`echo $cfile_path |awk -F/ '{print $NF}'`
          chk_db_read_dir=`ls -l |grep $chk_cfg_path |awk '{print $1}' |cut -c "2,3,4" |grep "r"`
          chk_db_write_dir=`ls -l |grep $chk_cfg_path |awk '{print $1}' |cut -c "2,3,4" |grep "w"`
          
          if [ -z "$chk_db_read_dir" ]
          then
            echo "  error> cfile_path : $cfile_path read permission denied"
            param_error_file="Y"
          fi

          if [ -z "$chk_db_write_dir" ]
          then
            echo "  error> cfile_path : $cfile_path write permission denied"
            param_error_file="Y"
          fi

        elif [ -n "$chk_move_path" ]
        then
          echo "  error> cfile_path : $cfile_path execute permission denied"
          param_error_file="Y"  
        fi
      fi
    fi

    # user_home permission check
    if [ -z "$user_home" ]
    then
      echo "  error> tbis.cfg : user_home"
      param_error_file="Y"
    else
      chk_move_path=`cd $user_home 2>&1`

      if [ -z "$chk_move_path" ]
      then
        cd $user_home
        cd ../

        chk_cfg_path=`echo $user_home |awk -F/ '{print $NF}'`
        chk_db_read_dir=`ls -l |grep $chk_cfg_path |awk '{print $1}' |cut -c "2,3,4" |grep "r"`
        chk_db_write_dir=`ls -l |grep $chk_cfg_path |awk '{print $1}' |cut -c "2,3,4" |grep "w"`
        
        if [ -z "$chk_db_read_dir" ]
        then
          echo "  error> user_home : $user_home read permission denied"
          param_error_file="Y"
        fi

        if [ -z "$chk_db_write_dir" ]
        then
          echo "  error> user_home : $user_home write permission denied"
          param_error_file="Y"
        fi

      elif [ -n "$chk_move_path" ]
      then
        echo "  error> user_home : $user_home execute permission denied"
        param_error_file="Y"  
      fi
    fi
  elif [ "$tbis_run_user" != "$user_name" ] && [ "$tbis_run_user" == "root" ]
  then
      echo
  fi
}

############################################################
# OS configuration check
############################################################
fun_os_error(){
  # init
  param_error_os="N"

  # check param
}

############################################################
# TIBERO configuration check
############################################################
fun_tb_error(){
  # init
  param_error_tibero="N"

  # check param
  if [ -z "$tibero_engine" ]
  then
    echo "  error> tbis.cfg : tibero_engine" 
    param_error_tibero="Y"
  fi
}

############################################################
# TIBERO libarary check
############################################################
fun_tblib_error(){
  param_error_lib="N"
  LANG=C
  # user_name profile file check
  profile_bashprofile_chk=$user_home/.bash_profile
  profile_profile_chk=$user_home/.profile

  if [ -f "$profile_profile_chk" ]
  then
      . $profile_profile_chk
  elif [ -f "$profile_bashprofile_chk" ]
  then
      . $profile_bashprofile_chk
  fi

  tbsvr_ldd_chk=`ldd "$TB_HOME"/bin/tbsvr |grep "not found"`
  tbsql_ldd_chk=`ldd "$TB_HOME"/client/bin/tbsql |grep "not found"`
  
  if [ -n "$tbsvr_ldd_chk" ] || [ -n "$tbsql_ldd_chk" ]
  then
    param_error_lib="Y"
    echo "  error> tbsvr library not found"
    ldd "$TB_HOME"/bin/tbsvr
    echo
    echo "  error> tbsql library not found"
    ldd "$TB_HOME"/client/bin/tbsql
    echo
    echo "  environment"
    echo "  - TB_HOME : $TB_HOME"
    echo "  - PATH : $PATH"
    echo "  - LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
    exit 1
  fi
}

############################################################
# error type
############################################################
input_error_type=$1

if [ "$input_error_type" == "lib" ]
then
  fun_tblib_error
else
  fun_file_error
  fun_os_error
  fun_tb_error
fi

############################################################
# error progress
############################################################
# go working directory
cd $tbis_current_path

# output error only "1. Installation"
if [ "$input_number" == "2" ] || [ "$input_number" == "3" ]
then
    param_error_file="N"
fi

# Y: exit
# N: continue
if [ "$param_error_file" == "Y" ] || [ "$param_error_os" == "Y" ] || [ "$param_error_tibero" == "Y" ] || [ "$param_error_lib" == "Y" ]
then
    exit 1
elif [ "$param_error_file" == "N" ] || [ "$param_error_os" == "N" ] || [ "$param_error_tibero" == "N" ] || [ "$param_error_lib" == "N" ]
then
    2>/dev/null
fi
