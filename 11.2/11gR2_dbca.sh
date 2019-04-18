#!/usr/bin/bash

#
# Tested CentOS 7
# Database creation, run as oracle user
#



dbca -silent -createDatabase -templateName General_Purpose.dbc -gdbname $ORACLE_SID -sid $ORACLE_SID -responseFile NO_VALUE -characterSet AL32UTF8 -memoryPercentage 10 -emConfiguration NONE -datafiledestination /ora/db001 -sysPassword SysPassword1 -systemPassword SysPassword1 -dbsnmpPassword SysPassword1 -sysmanPassword SysPassword1


