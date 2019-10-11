#!/bin/bash

function hash_dir(){
    log="68_"`date +%Y%m%d%H`"_hash.log"
    for file in `ls $1`
    do
        if [ -d $1"/"$file ]
        then
            hash_dir $1"/"$file
        else
           echo `md5 $1"/"$file`>>$log
        fi
    done
}

# test
hash_dir ~/workspace
