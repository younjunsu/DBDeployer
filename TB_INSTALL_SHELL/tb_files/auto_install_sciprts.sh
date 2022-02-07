
#!/bin/sh
#http://daplus.net/bash-%EC%89%98-%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8%EC%97%90-%EC%A7%84%ED%96%89%EB%A5%A0-%ED%91%9C%EC%8B%9C-%EC%A4%84%EC%9D%84-%EC%B6%94%EA%B0%80%ED%95%98%EB%8A%94-%EB%B0%A9%EB%B2%95/
#!/bin/bash
# 1. Create ProgressBar function
# 1.1 Input is currentState($1) and totalState($2)
function ProgressBar {
# Process data
    let _progress=(${1}*100/${2}*100)/100
    let _done=(${_progress}*4)/10
    let _left=40-$_done
# Build progressbar string lengths
    _fill=$(printf "%${_done}s")
    _empty=$(printf "%${_left}s")

# 1.2 Build progressbar strings and print the ProgressBar line
# 1.2.1 Output example:                           
# 1.2.1.1 Progress : [########################################] 100%
printf "\rProgress : [${_fill// /#}${_empty// /-}] ${_progress}%%"

}

# Variables
_start=1

# This accounts as the "totalState" variable for the ProgressBar function
_end=30

# Proof of concept
for number in $(seq ${_start} ${_end})
do
    sleep 1
    ProgressBar ${number} ${_end}
done
printf '\nFinished!\n



###### CONFIGURATION
## Control file Mutiplex 2
## Value Y or N
CONTROL_FILE_MULTI=Y

## 
###### PATH
TIBERO_ENGINE_PATH=/tibero/tibero6
TIBERO_DATA_PATH=/data
TIBERO_ARCHIVE_PATH=/archive


##### Configration Check Process


##### TIBERO ENGINE PATH Created directory
mkdir -p $TIBERO_ENGINE_PATH/tbctl1
mkdir -p $TIBERO_ENGINE_PATH/tbdata
mkdir -p $TIBERO_DATA_PATH/tbctl1
mkdir -p $TIBERO_DATA_PATH/tbctl1








