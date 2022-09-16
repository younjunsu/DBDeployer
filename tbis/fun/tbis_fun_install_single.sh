# tibero profile configuration apply
. $tbis_current_path/cfg/tbis_cfg_profile.sh output

# tibero db tip configuration apply
. $tbis_current_path/cfg/tbis_cfg_db.sh output

# tibero db tbdsn.tbr configuration apply
. $tbis_current_path/cfg/tbis_cfg_tbdsn.sh output

# change owner
. $tbis_current_path/fun/tbis_fun_action.sh chang_owner


echo "single"
