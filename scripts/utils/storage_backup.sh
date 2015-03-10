#!/bin/bash

#tar.gz /opt/storage
#encrypt with basic password...  (gpg> mheins)
#copy to destination passed in on $1
##
########
#exit
########


if [ -z "$1" -o -z "$2" -o -z "$3" -o -z "$4" ]; then
    echo "see usage <script> <gpg_passwd> <outputname> <src path> <dest path> <tar_options>"
    echo ""
    echo example: ./storage_backup.sh mheins backup_scriptsconfigs /opt/storage/mheins/ /opt/backups/ "--exclude=/opt/storage/mheins/www --exclude=/opt/storage/mheins/vmimages --exclude=/opt/storage/mheins/sandboxes"
    exit
fi

gpg_passwd=$1
name=$2
src=$3
dest=$4
tar_options=$5

tmp_dir=/tmp/storage_backup
stamp=$(date +%Y%m%d)
output=${name}_${stamp}.tar.gz
output_gpg=${output}.gpg


#attempt to make dest path
mkdir -p ${dest}

#setup tmp area
rm -rf $tmp_dir
mkdir -p $tmp_dir
cd $tmp_dir


tar -zcf ${output} ${tar_options} ${src} > /dev/null 2>&1
gpg --batch --passphrase ${gpg_passwd} -c ${output} > /dev/null 2>&1
mv ${output_gpg} ${dest}
rm -f ${output}
