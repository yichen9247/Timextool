#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH && LANG=en_US.UTF-8
export ToolPath="/usr/bin/timextool"

Red_Error() {
	printf '\033[1;31;10m%b\033[0m\n' "$@";
}

Warn_Error() {
	printf '\033[1;33;10m%b\033[0m\n' "$@";
}

filename=$(basename "$0") && filebase=$( base64 -d <<< dGltZXg= )
if [ "$filename" != "$filebase" ]; then
    printf "\n" && Red_Error "签名验证失败，文件名被修改！"
    printf "\n" && exit 1
fi

function outputHitokoto() {
    printf "\n"
    if [ -f /usr/bin/curl ]; then 
        export hitokoto=$(curl -s https://v1.hitokoto.cn/?encode=text) && Success_Error "$hitokoto"
    else 
        Red_Error "请先安装CURL!"
    fi;
    printf "\n"
}

function getnetIpaddress() {
    printf "\n"
    if [ -f /usr/bin/curl ]; then 
        export ipaddress=$(curl -s https://api.bt.cn/api/getipaddress) && Success_Error "$ipaddress"
    else 
        Red_Error "请先安装CURL!"
    fi;
    printf "\n"
}

function docheckVersion() {
    export localver=$(cat ${ToolPath}/cache/timex.ver | awk 'NR==1{print $1}')
    export timexver=$(cat ${ToolPath}/cache/timex.ver  | awk 'NR==1{print $2}')
    if [ "$timexver" == "FOR-N" ]; then
        Red_Error "程序运行时遇到未知的错误！" && exit 1
    elif [ "$timexver" == "FOR-S" ]; then
        sh ${ToolPath}/Bash/linuxtool.sh
    elif [ "$timexver" == "FOR-C1" ]; then
        ${ToolPath}/C1/linuxtool
    elif [ "$timexver" == "FOR-C2" ]; then
        ${ToolPath}/C2/linuxtool
    elif [ "$timexver" == "FOR-P" ]; then
        python3 ${ToolPath}/Python/linuxtool.py
    elif [ "$timexver" == "FOR-V" ]; then
        cd ${ToolPath}/Java && java linuxtool
    else
        Red_Error "程序运行时遇到未知的错误！" && exit 1
    fi
}

function checkToolExport() {
    if [ ! -d "${ToolPath}" ]; then
        printf "\n" && Red_Error "关键文件不存在，请重新安装！"
        exit 1
    fi
    
    if [ ! -d "${ToolPath}/cache" ]; then
        mkdir ${ToolPath}/cahce
    fi
}

checkToolExport && docheckVersion