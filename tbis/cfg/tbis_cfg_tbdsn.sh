# tbdsn.tbr configuration
fun_tbdns(){
    echo "$TB_SID=("
    echo "  (INSTANCE=(HOST=localhost)"
    echo "  (PORT=$LISTENER_PORT)"
    echo "  (DB_NAME=$DB_NAME)"
    echo "  )"
    echo ")"
}

# tbdsn mode check
# apply: create profile file
# output: display output
cfg_tbdsn_mode=$1

if [ -z $"cfg_tbdsn_mode" ]
then
    2>/dev/null
elif [ "$cfg_tbdsn_mode" == "apply" ]
then
    fun_tbdns >> "$TB_HOME"/client/config/tbdsn.tbr
elif [ "$cfg_tbdsn_mode" == "output" ]
then
    fun_tbdns
fi
