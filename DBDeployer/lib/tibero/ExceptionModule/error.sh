# env
#--------------------------------------------------------------------------------
. $current_path/config/tibero.cfg
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
function fn_error_tibero_library(){
  stop_tibero_library="N"
}
#--------------------------------------------------------------------------------

#
#--------------------------------------------------------------------------------
function fn_error_tibero_config(){
  stop_tibero_config="N"
}
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
function fn_error_tibero_os(){
  stop_tibero_os="N"
}
#--------------------------------------------------------------------------------

#
#--------------------------------------------------------------------------------
function fn_error_tibero_process(){
  stop_tibero_process="N"
}
#--------------------------------------------------------------------------------




# 
#--------------------------------------------------------------------------------
if [ "$stop_tibero_process" == "Y" ] || [ "$stop_tibero_process" == "Y" ] || [ "$stop_tibero_process" == "Y" ]
then
  exit
fi
#--------------------------------------------------------------------------------