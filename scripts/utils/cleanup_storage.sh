#!/bin/bash

if [ -z "$1" -o -z "$2" -o -z "$3" -o -z "$4" ]; then
    echo "see usage <script> <target_path> <name_filter> <days_old> <min_backup_count>"
    exit
fi

target_path=$1
name_filter=$2
days_old=$3
min_backup_count=$4


#check for minimum saved count before deleting
backup_count=$(find ${target_path} -maxdepth 1 -name "$name_filter" -print | wc -l)
if [ "${backup_count}" -lt "${min_backup_count}" ]; then
    exit 1
fi


#delete any backups older than x days
find ${target_path} -maxdepth 1 -mtime +${days_old} -name "$name_filter" -print -exec rm {} \; > /dev/null 2>&1

exit 0
