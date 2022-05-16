# tbinstall


## RUN
```
#./tbis
```

## MAIN
```
[*] TIBERO Installation Shell Script
[*] This script is for TmaxTibero Daejeon Office only.
[*] Supported Version : Tibero 6 FS07 ↑
-----------------------------------------------------------------
# 1. tbis Installation Tools
# 2. tbis Installation Report
# 3. tbis Configuration Text
-----------------------------------------------------------------
# press other key to quit
-----------------------------------------------------------------
Choose the Number : 
```


## 1. tbis Installation Tools
```
[*] TIBERO Auto installation Tools Configuration Checking STEP
-----------------------------------------------------------------
# Installation Mode
- Installation type : TAC
- Installation node : cm0
-----------------------------------------------------------------
# OS USER & GROUP
- OS user : tibero
- OS home : /tibero
- OS user group : dba
-----------------------------------------------------------------
# TIBERO DATABASE
- TB_SID : tibero0
- TB_HOME : /tibero/tibero6
- DB_NAME : tibero
- LISTENER_PORT : 8629
- CHARACTER SET : UTF8
-----------------------------------------------------------------
# TIBERO CM
- CM_SID : cm0
- CM_HOME : /tibero/tibero6
- NODE1_INTER_IP : 192.168.152.31
- NODE2_INTER_IP : 192.168.152.32
- NODE1_VIP_ETH : ens36
- NODE1_VIP_IP : 192.168.78.33
- NODE2_VIP_ETH : ens36
- NODE2_VIP_IP : 192.168.78.34
-----------------------------------------------------------------
# TIBERO DATABASE FILE DEST
- TB_HOME PATH : /tibero/tibero6
- TBINARY PATH : /tibero/tibero6/tbinary
- CONTROL1_FILE : /SHARE_FILES/TAC_DATA/tibero/tbctl1/c1.ctl
- CONTROL2_FILE : /SHARE_FILES/TAC_DATA/tibero/tbctl2/c2.ctl
- DB_CREATE_FILE : /SHARE_FILES/TAC_DATA/tibero/tbdata
- LOG_ARCHIVE_FILE : /SHARE_FILES/TAC_DATA/tibero/tbarch0
-----------------------------------------------------------------
# TIBERO INSTALLATION BINARY 
- LICENSE FILE : ../binary/license.xml
- ENGINE FILE : ../binary/tibero6-bin-FS07_CS_2005-linux64_3.10-200518-opt-20220216111303_tested.tar
- TBINARY FILE : 
-----------------------------------------------------------------
# TIBERO Configuration Files
- cat tbis.cfg : TIBERO Configuration File
- cat tbis.sql : CREATE DATABASE SQL File
-----------------------------------------------------------------

continue ? ( [Y]es / [N]o / [AA] All Auto] ) : 
```

## 2. tbis Installation Report
```
TIBERO AUTO INSTALLATION REPORT
-----------------------------------------------------------------
# 1. tbboot -l
# 2. ncpu
# 3. installation infomation
# 4. profile
# 5. CREATE DATABASE sql
# 6. instance tip
# 7. datafile infomation
# 8. tablespace infomation
# 9. OS infomation
# 10. tbiobench
-----------------------------------------------------------------
b - before
press other key to quit
-----------------------------------------------------------------
Choose the Number : 
```

## 3. tbis Configuration Text
```
# TIBERO auto configuration text
- Step by step
-----------------------------------------------------------------
# Installation Mode
- Installation type : TAC
- Installation node : cm0
-----------------------------------------------------------------

# Operation System
-----------------------------------------------------------------
# 1. OS user
# 2. Profile
# 3. Home directory concept
-----------------------------------------------------------------

# DATABASE
-----------------------------------------------------------------
# 10. Instance tip
# 11. tbdsn.tbr
# 12. CREATE DATABASE SQL Syntax
-----------------------------------------------------------------

# Cluster Manager 
-----------------------------------------------------------------
# 20. CM tip
# 21. CM resource
-----------------------------------------------------------------

b - before
press other key to quit
-----------------------------------------------------------------
Choose the Number : 
```
