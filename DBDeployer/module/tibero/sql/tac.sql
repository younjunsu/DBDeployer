--------------------------------------------------------------------------------
-- QUERY: TAC thread enable
--------------------------------------------------------------------------------
CREATE UNDO TABLESPACE UNDO1 DATAFILE 'system/undo101.dtf' SIZE $THREAD1_UNDO1_SIZE AUTOEXTEND OFF;
ALTER DATABASE ADD LOGFILE THREAD 1 GROUP 5 ('$DB_CREATE_FILE_DEST/tbdata/system/redo051.redo','$DB_CREATE_FILE_DEST/tbdata/system/redo052.redo') SIZE $THREAD1_REDO_SIZE;
ALTER DATABASE ADD LOGFILE THREAD 1 GROUP 6 ('$DB_CREATE_FILE_DEST/tbdata/system/redo061.redo','$DB_CREATE_FILE_DEST/tbdata/system/redo062.redo') SIZE $THREAD1_REDO_SIZE;
ALTER DATABASE ADD LOGFILE THREAD 1 GROUP 7 ('$DB_CREATE_FILE_DEST/tbdata/system/redo071.redo','$DB_CREATE_FILE_DEST/tbdata/system/redo072.redo') SIZE $THREAD1_REDO_SIZE;
ALTER DATABASE ADD LOGFILE THREAD 1 GROUP 8 ('$DB_CREATE_FILE_DEST/tbdata/system/redo081.redo','$DB_CREATE_FILE_DEST/tbdata/system/redo082.redo') SIZE $THREAD1_REDO_SIZE;
ALTER DATABASE ADD LOGFILE THREAD 1 GROUP 9 ('$DB_CREATE_FILE_DEST/tbdata/system/redo091.redo','$DB_CREATE_FILE_DEST/tbdata/system/redo092.redo') SIZE $THREAD1_REDO_SIZE;
ALTER DATABASE ENABLE PUBLIC THREAD 1;