#!/bin/sh
clear
echo "* TIBERO Installation Shell Script"
echo "* This script is for Tibero "Daejeon Office" only."
echo "" > result_file
echo "1 auto"
echo "2 manual"
read ch_input
case $ch_input in 
1)
## AUTO SET
    echo "1. SINGLE"
    echo "2. TSC"
    echo "3. TAC"
    ###

    echo "1. bash_profile"
    echo "2. profile"
    echo -n "tibero env file"
    read TBR_ENV

    case $TBR_ENV in
    1)
        echo "cat ./files/tb_profile.txt >> .bash_profile" >> result_file
    ;;
    2)
        echo "cat ./files/tb_profile.txt >> .profile" >> result_file
    ;;
    esac
;;
2)
echo "2. PART AUTO SET"
    echo " -----------------------------------------------------------------------------------"
    echo "  1.TIBERO TYPE                           |  2.TIBERO USER CREATE                   "
    echo " ---------------------------------------- + ----------------------------------------"
    echo "  11 - SINGLE                             |  21 - tibero                            "
    echo "  12 - TSC                                |  22 - obs                               "
    echo "  13 - TAC                                |  23 - crd                               "
    echo "  14 - OBSERVER                           |  24 - MANUAL                            "
    echo " -----------------------------------------------------------------------------------"
    echo "  3.TIBERO User Profile                   |  4.TIBERO Directory                     "
    echo " ---------------------------------------- + ----------------------------------------"
    echo "  31 - .bash_profile                      |  41 - TIBERO PATH                       "
    echo "  32 - .profile                           |  42 - TIBERO DATA PATH                  "
    echo "  33 - MANUAL                             |  43 - TIBERO ARCHIVE                    "
    echo "                                          |  44 - TIBERO ControllFile               "
    echo "                                          |  45 - MANUAL                            "
    echo " -----------------------------------------------------------------------------------"
    echo "  5.TIBERO TIP                            |  6.TIBERO CREATE DATABASE               "
    echo " ---------------------------------------- + ----------------------------------------"
    echo "  31 - TB_SID TIP                         |  41 - SQL                               "
    echo "  32 - TB_CM TIP                          |  42 - MANUAL                            "
    echo "  33 - MANUAL                             |                                         "
    echo " -----------------------------------------------------------------------------------"
    echo "  7.TIBERO Cluster Resource               |  8.TIBERO Check                         "
    echo " ---------------------------------------- + ----------------------------------------"
    echo "  31 - Resource Command                   |  41 - CHECK                             "
    echo "  32 - MANUAL                             |                                         "
    echo " -----------------------------------------------------------------------------------"
    echo -n " Choose the Number or Command : "

    read input_nubmer_menu
    case $input_nubmer_menu in
    11)
    echo "SINGLE"
    echo "2.TIBERO USER CREATE"
    echo "3.TIBERO User Profile"
    echo "4.TIBERO Directory"
    echo "5.TIBERO TIP"
    echo "6.TIBERO CREATE DATABASE"
    echo "7.TIBERO Cluster Resource"
    echo "8.TIBERO Check"
    ;;
    12)
    echo "TSC"
    echo "2.TIBERO USER CREATE"
    echo "3.TIBERO User Profile"
    echo "4.TIBERO Directory"
    echo "5.TIBERO TIP"
    echo "6.TIBERO CREATE DATABASE"
    echo "7.TIBERO Cluster Resource"
    echo "8.TIBERO Check"
    ;;
    13)
    echo "TAC"
    echo "2.TIBERO USER CREATE"
    echo "3.TIBERO User Profile"
    echo "4.TIBERO Directory"
    echo "5.TIBERO TIP"
    echo "6.TIBERO CREATE DATABASE"
    echo "7.TIBERO Cluster Resource"
    echo "8.TIBERO Check"
    ;;
    14)
    echo "OBSERVER"
    echo "2.TIBERO USER CREATE"
    echo "3.TIBERO User Profile"
    echo "4.TIBERO Directory"
    echo "5.TIBERO TIP"
    echo "6.TIBERO CREATE DATABASE"
    echo "7.TIBERO Cluster Resource"
    echo "8.TIBERO Check"
    ;;
    21)
    echo -n "GROUP USER : " 
    read GROUP_NM
    echo -n "TIBERO HOME PATH : " 
    read USER_PATH
    echo "USER CREATE COMMAND"
    echo "groupadd $GROUP_NM"
    echo "useradd tibero -d $USER_PATH -g $GROUP_NM"
    echo
    ;;
    22)
    echo -n "GROUP USER : " 
    read GROUP_NM
    echo -n "OBS HOME PATH : " 
    read USER_PATH
    echo "USER CREATE COMMAND"
    echo "groupadd $GROUP_NM"
    echo "useradd obs -d $USER_PATH -g $GROUP_NM"
    echo
    ;;
    23)
    echo -n "GROUP USER : " 
    read GROUP_NM
    echo -n "CRD HOME PATH : " 
    read USER_PATH
    echo "USER CREATE COMMAND"
    echo "groupadd $GROUP_NM"
    echo "useradd crd -d $USER_PATH -g $GROUP_NM"
    ;;
    24)
    echo 24
    ;;
    31)
    echo 31
    ;;
    32)
    echo 32
    ;;
    33)
    echo 33
    ;; 
    41)
    echo -n "TIBERO ENGINE"
    read TBR_ENG
    echo -n "TIBERO DATA"
    read TBR_DF
    echo -n "TIBERO ARCHIVE"
    read TBR_ARC
    echo -n "TIBERO CTL1"
    read TBR_CTL1
    echo -n "TIBERO CTL2"
    read TBR_CTL2

    echo "mkdir -p $TBR_ENG"
    echo "mkdir -p $TBR_DF"
    echo "mkdir -p $TBR_ARC"
    echo "mkdir -p $TBR_CTL1"
    echo "mkdir -p $TBR_CTL2"
    ;;
    42)
    echo 42
    ;;
    43)
    echo 43
    ;;
    44)
    echo 44
    ;;
    45)
    echo 45
    ;;
    51)
    echo 51
    ;;
    52)
    echo 52
    ;;
    53)
    echo 53
    ;;
    61)
    echo 61
    ;;
    62)
    echo 62
    ;;
    71)
    echo 71
    ;;
    72)
    echo 72
    ;;
    81)
    echo 81
    ;;
    esac
;;
esac