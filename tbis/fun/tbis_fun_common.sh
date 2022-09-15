#!/bin/sh

############################################################
# 
############################################################
# display output mode
input_type=$1

# display output message
case $input_type in
    "press")
        echo "Press Enter Key to continue...";;
    "success")
        echo ""
        echo "  Success> Step : "$tbis_step
        echo "";;
    *)
        exit 1;;
esac
