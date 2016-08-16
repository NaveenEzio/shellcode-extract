#!/bin/bash

if [ -z $1 ] ; then
    echo "Need first argument to be an executable"
    exit
fi

strip $1
lines=`objdump -d $1 | cut -f2 -`
start="FALSE"
for bytes in $lines ; do
    if [[ $start == "TRUE" ]] ; then
        printf "\\\x%s" $bytes
        #echo $bytes
        continue
    fi

    if [ -z `echo $bytes | grep \<\.text\>:` ] ; then
        continue
    else
        start="TRUE"
    fi
done

echo
