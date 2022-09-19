#!/bin/sh

############################################################
# 
############################################################
# display output mode
input_type=$1

# display output message
case $input_type in
    "press")
        echo "  Press Enter Key to continue...";;
    "success")
        echo ""
        echo "  Success> Step : "$tbis_step
        echo "";;
    "progress_chk")
        if [ "$all_auto_enable" == "Y" ]
        then
            export progress_yesno="YES"
        else
            printf "  continue ? ( [Y]es / [N]o / [S]kip ) : "
            read input_yesno
            case $input_yesno in
                "Y"|"y")
                    export progress_yesno="YES"
                    ;;
                "N"|"n")
                    export progress_yesno="NO"
                    exit 1
                    ;;
                "S"|"s")
                    export progress_yesno="SKIP"
                    ;;
                *)
                    exit
                    ;;
            esac
            echo
        fi
        ;;
    *)
        exit 1;;
esac
