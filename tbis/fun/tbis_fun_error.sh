# chk
# cfg
# param

############################################################
# env
############################################################
. cfg/tbis_cfg_main.sh

############################################################
# file configuration check
############################################################
# init
param_error_file="N"

# check param
chk_engine_file=test
if [ -z "$chk_engine_file" ]
then
  echo "  error> tibero engine file check"
  param_error_file="Y"
fi


############################################################
# OS configuration check
############################################################
# init
param_error_os="N"

# check param

############################################################
# TIBERO configuration check
############################################################
# init
param_error_tibero="N"

# check param
if [ -z "$tibero_engine" ]
then
  echo "  error> tbis_cfg.main: tibero_engine"  
  param_error_tibero="Y"
fi


############################################################
# error progress
############################################################
# Y: exit
# N: continue

if [ "$input_number" == "2" ] || [ "$input_number" == "3" ]
then
    param_error_file="N"
fi

if [ "$param_error_file" == "Y" ] || [ "$param_error_os" == "Y" ] || [ "$param_error_tibero" == "Y" ]
then
    exit 1
elif [ "$param_error_file" == "N" ] || [ "$param_error_os" == "N" ] || [ "$param_error_tibero" == "N" ]
then
    2>/dev/null
fi