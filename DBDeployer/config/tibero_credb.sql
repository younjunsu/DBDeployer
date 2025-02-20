CREATE DATABASE 
USER sys IDENTIFIED BY 'tibero' 
MAXDATAFILES 256
CHARACTER SET UTF8
LOGFILE 
GROUP 0 ('system/redo001.redo','system/redo002.redo') SIZE 100M,
GROUP 1 ('system/redo011.redo','system/redo012.redo') SIZE 100M,
GROUP 2 ('system/redo021.redo','system/redo022.redo') SIZE 100M,
GROUP 3 ('system/redo031.redo','system/redo032.redo') SIZE 100M,
GROUP 4 ('system/redo041.redo','system/redo042.redo') SIZE 100M
MAXLOGFILES 100
MAXLOGMEMBERS 8
--MAXARCHIVELOG 500
--MAXLOGHISTORY 500
ARCHIVELOG
    DATAFILE 'system/system001.dtf' SIZE 100M autoextend on
    UNDO TABLESPACE UNDO0 DATAFILE 'system/undo001.dtf' SIZE 100M autoextend on
    DEFAULT TEMPORARY TABLESPACE TEMP TEMPFILE 'system/temp001.dtf' SIZE 100M autoextend on
    DEFAULT TABLESPACE USR DATAFILE 'system/usr001.dtf' SIZE 100M autoextend on;
