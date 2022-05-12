CREATE DATABASE 
USER sys IDENTIFIED BY 'tibero' 
MAXDATAFILES 256
/*
    * ORACLE to TIBERO
        - UTF8      -> UTF8
        - KSC5601   -> EUCKR or MSWIN949
        - ASCII     -> ASCII
        - MSWIN949  -> MSWIN949
*/
CHARACTER SET UTF8
LOGFILE 
GROUP 0 ('system/redo001.redo','system/redo002.redo') SIZE 300M,
GROUP 1 ('system/redo011.redo','system/redo012.redo') SIZE 300M,
GROUP 2 ('system/redo021.redo','system/redo022.redo') SIZE 300M,
GROUP 3 ('system/redo031.redo','system/redo032.redo') SIZE 300M,
GROUP 4 ('system/redo041.redo','system/redo042.redo') SIZE 300M
MAXLOGFILES 100
MAXLOGMEMBERS 8 
--MAXARCHIVELOG 500
--MAXLOGHISTORY 500
ARCHIVELOG
    DATAFILE 'system/system001.dtf' SIZE 10G
    UNDO TABLESPACE UNDO0 DATAFILE 'system/undo001.dtf' SIZE 10G 
    DEFAULT TEMPORARY TABLESPACE TEMP TEMPFILE 'system/temp001.dtf' SIZE 10G 
    DEFAULT TABLESPACE USR DATAFILE 'system/usr001.dtf' SIZE 10G 
    -- TPR 추가(system 디렉토리 구분 시 TPR 필수로 들어가야함)
;
