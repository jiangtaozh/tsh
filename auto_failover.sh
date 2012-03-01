#!/bin/bash
################################################################################
#@
#@ Script Name:        Automatic failover testing script
#@
#@ Author:             Tom Zhang
#@
#@ Description:
#@ This script is used to automatically execute sppctrl stop/start command and get
#@ the system status in the specefied log file.
#@
#@ Notes:
#@   In all the functions, return value 0 means success, 1 stands for fail, This
#@ is also stardard for system shell command.
#@
#@ Histoty:
#@ 02/28/12  Tom Zhang    Intial version.
################################################################################

LOG_FILE=$HOME/auto_test_failover.log
SLEEP_SECONDS=1

function logMsg
{
	msg="<`date +'%y-%m-%d %H:%M:%S'`> $@\n"
	echo $msg
	echo $msg >>$LOG_FILE
}

function execute
{
        command=$@
	msg="<`date +'%y-%m-%d %H:%M:%S'`> execute command: $@\n"
	echo $msg >>$LOG_FILE
        eval out=\$\($command\)
        echo $out
        echo $out >> $LOG_FILE 2>&1
        return $?
}

logMsg "starting to execute automatically failover testing..."
execute "ls | wc -l"
logMsg "end to execute automatically failover testing..."

exit 0

