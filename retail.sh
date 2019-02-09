#!/bin/bash

#
# Re-tail a file starting at an offset with a output delay for each line
#

set -e

file_path=${1}
n=${2}
delay=${3}

if [[ -z ${file_path} || -z ${n} || -z ${delay} ]]; then
    printf "Usage: ./retail.sh <file> <last n lines> <delay in seconds>\n"
    false
fi

if [ -f ${file_path} ]; then
    line_end=$(awk 'END {print NR}' ${file_path})
    line_start=$((line_end-n+1))

    if [ ${line_start} -gt 0 ]; then
        for ((i=${line_start}; i <=${line_end}; i++)); do
            sed -n ${i}p ${file_path}
            sleep ${delay}
        done
    else
        printf "File line count is too small\n"
        false
    fi
else
    printf "File does not exist\n"
    false
fi

exit 0
