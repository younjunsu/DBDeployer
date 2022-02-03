#!/bin/sh
clear
echo "* TIBERO Installation Shell Script"
echo "* This script is for Tibero "Daejeon Office" only."


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
    echo "  31 - .bash_profile                      |  41 - TIBERO ENGINE PATH                "
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
    echo 11
    ;;
    12)
    echo 12
    ;;
    13)
    echo 13
    ;;
    14)
    echo 14 
    ;;
    21)
    echo 21
    ;;
    22)
    echo 22
    ;;
    23)
    echo 23
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
    echo 41
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