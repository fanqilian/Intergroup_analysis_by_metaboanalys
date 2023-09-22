#!/bin/bash

usage() {
    echo "Usage: sh $0 workplace group_path"
    echo "workplace: 工作全路径，含有clean表"
    echo "group_path: 分组表全路径"
    exit 1
}

# check if enough parameters are provided
if [ "$#" -ne 2 ] || [ "$1" = "-h" ]; then
    usage
fi

workplace=$1
group_path=$2

# Run python script
python "/home/qilianfan/metabotlas/Main.py" "$1" "$2"

