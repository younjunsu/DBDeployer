############################################################
# TIBERO single
############################################################

# tibero engine install
. $tbis_current_path/function/tbis_fun_action.sh fun_engine

# tibero tbinary install
. $tbis_current_path/function/tbis_fun_action.sh fun_tbinary

# tibero license apply
. $tbis_current_path/function/tbis_fun_action.sh fun_license

# tibero profile configuration apply
. $tbis_current_path/config/tbis_cfg_profile.sh apply

# tibero env apply
. $profile_path

# tibero db tip configuration apply
. $tbis_current_path/config/tbis_cfg_db.sh apply

# tibero db tbdsn.tbr configuration apply
. $tbis_current_path/config/tbis_cfg_tbdsn.sh apply

# change owner
. $tbis_current_path/function/tbis_fun_action.sh fun_change_owner

# tibero boot mount
. $tbis_current_path/function/tbis_fun_action.sh fun_tbboot nomount

# tibero create database sql
. $tbis_current_path/function/tbis_fun_action.sh fun_credb

# tibero boot normal
. $tbis_current_path/function/tbis_fun_action.sh fun_tbboot normal

# tibero system.sh
. $tbis_current_path/function/tbis_fun_action.sh fun_system_shell

# tibero process check
. $tbis_current_path/function/tbis_fun_action.sh fun_process_chk

# tibero down immedate
. $tbis_current_path/function/tbis_fun_action.sh fun_tbdown immediate

# change owner
. $tbis_current_path/function/tbis_fun_action.sh fun_change_owner
