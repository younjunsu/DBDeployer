#
#--------------------------------------------------------------------------------
function fn_step_yesno(){
    if [ "$all_auto_enable" == "Y" ]
    then
        export step_yesno="YES"
    else
        printf "  continue ? ( [Y]es / [N]o / [S]kip ) : "
        read step_yesno

        case $step_yesno in
            "Y"|"y")
                export step_yesno="Y"
                ;;
            "N"|"n")
                export step_yesno="N"
                exit
                ;;
            "S"|"s")
                export step_yesno="S"
                ;;
            *)
                exit
                ;;
        esac
        echo ""
    fi
}
#--------------------------------------------------------------------------------


#
#--------------------------------------------------------------------------------
common_option1=$1

case $common_option1 in
    "fn_step_yesno")
        fn_step_yesno
        ;;
esac
#--------------------------------------------------------------------------------
