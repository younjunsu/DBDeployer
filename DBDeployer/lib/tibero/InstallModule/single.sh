# TIBERO single
#-------------------------------------------------------------------------------

# tibero engine install
. $current_path/lib/tibero/GeneratorModule/action.sh fn_engine

# tibero tbinary install
. $current_path/lib/tibero/GeneratorModule/action.sh fn_tbinary

# tibero license apply
. $current_path/lib/tibero/GeneratorModule/action.sh fn_license

# tibero profile configuration apply
. $current_path/lib/tibero/GeneratorModule/generator.sh fn_profile apply

# tibero env apply
. $profile_path

# tibero db tip configuration apply
. $current_path/lib/tibero/GeneratorModule/generator.sh fn_instance_tip apply

# tibero db tbdsn.tbr configuration apply
. $current_path/lib/tibero/GeneratorModule/generator.sh fn_tbdsn apply

# change owner
. $current_path/lib/tibero/GeneratorModule/action.sh fn_owner_change

# tibero boot mount
. $current_path/lib/tibero/GeneratorModule/action.sh fn_tibero_boot mount

# tibero create database sql
. $current_path/lib/tibero/GeneratorModule/action.sh fn_tibero_create_database

# tibero boot normal
. $current_path/lib/tibero/GeneratorModule/action.sh fn_tibero_boot normal

# tibero system.sh
. $current_path/lib/tibero/GeneratorModule/action.sh fn_tibero_system_shell

# tibero down immedate
. $current_path/lib/tibero/GeneratorModule/action.sh fn_tibero_down immediate

# change owner
. $current_path/lib/tibero/GeneratorModule/action.sh fn_owner_change
