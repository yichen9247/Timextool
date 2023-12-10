#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export command="$1"
export PATH && LANG=en_US.UTF-8
export ToolPath="/usr/bin/timextool"

Red_Error() {
	printf '\033[1;31;10m%b\033[0m\n' "$@";
}

Warn_Error() {
	printf '\033[1;33;10m%b\033[0m\n' "$@";
}

Black_Error() {
	printf '\033[1;30;10m%b\033[0m\n' "$@";
}

Green_Error() {
	printf '\033[1;36;10m%b\037[0m\n' "$@";
}

White_Error() {
	printf '\033[1;33;10m%b\033[0m\n' "$@";
}

Notice_Error() {
    printf '\033[1;34;10m%b\033[0m\n' "$@";
}

Purple_Error() {
    printf '\033[1;35;10m%b\033[0m\n' "$@";
}

Success_Error() {
	printf '\033[1;32;10m%b\033[0m\n' "$@";
}

IRed_Error() {
	printf '\033[1;31;10m%b\033[0m' "$@";
}

IWarn_Error() {
	printf '\033[1;33;10m%b\033[0m' "$@";
}

IBlack_Error() {
	printf '\033[1;30;10m%b\033[0m' "$@";
}

IGreen_Error() {
	printf '\033[1;36;10m%b\037[0m' "$@";
}

Ihite_Error() {
	printf '\033[1;33;10m%b\033[0m' "$@";
}

INotice_Error() {
    printf '\033[1;34;10m%b\033[0m' "$@";
}

IPurple_Error() {
    printf '\033[1;35;10m%b\033[0m' "$@";
}

ISuccess_Error() {
	printf '\033[1;32;10m%b\033[0m' "$@";
}

export toolVersion=$( base64 -d <<< MS4xLjMtQmV0YQ== )

filename=$(basename "$0") && filebase=$( base64 -d <<< eGN0bA== )
if [ "$filename" != "$filebase" ]; then
    printf "\n" && Red_Error "签名验证失败，文件名被修改！"
    printf "\n" && exit 1
fi

function checkInstalled() {
    type $1 > /dev/null 2>&1
    if test $? -eq 1; then
        return 1
    else
        return 0
    fi
}

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

function optionPanel() {
    
    icaddress=$(hostname -I | awk 'NR==1{print $1}')
    ipaddress=$(curl -s https://api.bt.cn/api/getipaddress)
    dockerid=$(docker ps | grep timexpanel | awk '{print $1}')
    panelver=$(cat ${ToolPath}/panel/cache/panel.ver | awk 'NR==1{print $2}')
    panelport=$(cat ${ToolPath}/panel/cache/panel.ver | awk 'NR==1{print $3}')
    
    if [ "$1" == "OpenPanel" ]; then
        if [ "$panelver" == "Open" ]; then
            Warn_Error "\n当前面板已经是运行状态!\n"
        elif [ "$panelver" == "Close" ]; then
            printf "\n" && Success_Error "控制面板启动成功！\n"
            echo "PanelTrue Open ${panelport}" > ${ToolPath}/panel/cache/panel.ver
            sleep 0.5 && export docker run -d -p ${panelport}:80 timexpanel > /dev/null 2>&1
        else
            Red_Error "\n面板程序发生异常，或是没有权限导致!\n"
        fi
    elif [ "$1" == "ClosePanel" ]; then
        if [ "$panelver" == "Close" ]; then
            Warn_Error "\n当前面板已经是停止状态!\n"
        elif [ "$panelver" == "Open" ]; then
            echo "PanelTrue Close ${panelport}" > ${ToolPath}/panel/cache/panel.ver
            docker stop $dockerid > /dev/null 2>&1 && Success_Error "\n控制面板停止成功！\n"
        else
            Red_Error "\n面板程序发生异常，或是没有权限导致!\n"
        fi
    elif [ "$1" == "Uninstall" ]; then
        printf "\n"
        echo -n "是否卸载TimeX Panel面板（Y/N）：" && read ask_uninstall
        if [ "$ask_uninstall" == "Y" ] || [ "$ask_uninstall" == "y" ]; then
            printf "\n" && echo "— 正在检测面板状态 —"
            if [ "$panelver" == "Open" ]; then
                printf "\n" && echo "— 正在停止面板服务 —"
                sleep 0.5 && docker stop $dockerid > /dev/null 2>&1
                echo "PanelTrue Close ${panelport}" > ${ToolPath}/panel/cache/panel.ver
            fi
            printf "\n" && echo "— 正在删除面板容器 —"
            sleep 0.5 && docker rm $dockerid > /dev/null 2>&1
            sleep 0.5 && docker rm $(docker ps -a | grep timexpanel | awk '{print $1}') > /dev/null 2>&1
            printf "\n" && echo "— 正在删除命令模块 —"
            sleep 0.5 && rm -rf /usr/local/bin/xctl
            printf "\n" && echo "— 正在删除面板文件 —"
            sleep 0.5 && rm -rf ${ToolPath}/panel > /dev/null 2>&1
            printf "\n" && Success_Error "已成功卸载TimeX Panel面板！\n"
        else
            echo "已取消卸载TimeX Panel！\n"
        fi
    elif [ "$1" == "ChangePort" ]; then
            sleep 0.5 && printf "\n"
            echo -n "请输入要更改的面板端口：" && read ask_panel_port
            printf "\n" && echo "— 正在检测面板状态 —"
            if [ "$panelver" == "Open" ]; then
                printf "\n" && echo "— 正在停止面板服务 —"
                sleep 0.5 && docker stop $dockerid > /dev/null 2>&1
                echo "PanelTrue Close ${panelport}" > ${ToolPath}/panel/cache/panel.ver
            fi
            printf "\n" && echo "— 正在更改面板端口 —"
            echo "PanelTrue Close ${ask_panel_port}" > ${ToolPath}/panel/cache/panel.ver
            panelport=$(cat ${ToolPath}/panel/cache/panel.ver | awk 'NR==1{print $3}')
            printf "\n" && echo "— 正在重启面板服务 —"
            echo "PanelTrue Open ${panelport}" > ${ToolPath}/panel/cache/panel.ver
            docker run -d -p ${panelport}:80 timexpanel > /dev/null 2>&1 && optionPanel "lookasdefault"
    elif [ "$1" == "lookasdefault" ]; then
        printf "\n"
        echo "===============时光控制台程序=================="
        printf "\n"
        
        echo " - 内网访问地址：http://${icaddress}:${panelport}"
        echo " - "
        echo " - 外网访问地址：http://${ipaddress}:${panelport}"
        
        printf "\n"
        echo "==============================================="
    fi
}

function aboutPanelss() {
    checkInstalled figlet
    if test $? -eq 1; then
        printf "正在安装相关依赖包！\n"
        checkInstalled yum
        if test $? -eq 0; then
            yum install -y figlet
        fi
        checkInstalled apt-get
        if test $? -eq 0; then
            sudo apt-get install figlet
        fi
        Success_Error "相关依赖包安装完成！"
    fi
    figlet TIMEX PANEL && printf "\n"
    echo "————————————————————————————————————————————————————————"
    echo "NAME: TimeX Panel"
    echo "AUTHOR: HUA"
    echo "VERSION：${toolVersion}"
    echo "DESCRIBE：A control panel for an integrated utility"
    echo "————————————————————————————————————————————————————————"
}

function commandTools() {
    echo "===============时光控制台程序=================="
    
    echo "  (1) 启动控制面板           (2) 停止控制面板"
    echo "  (3) 更改登录账号           (4) 更改登录密码"
    echo "  (5) 卸载控制面板           (6) 更改面板端口"
    echo "  (7) 查看面板信息           (8) 关于时光面板"
    
    echo "==============================================="
    echo -n "请输入命令编号：" && read num
    if test $[num] -eq 1; then
        optionPanel "OpenPanel"
    elif test $[num] -eq 2; then
        optionPanel "ClosePanel"
    elif test $[num] -eq 5; then
        optionPanel "Uninstall"
    elif test $[num] -eq 6; then
        optionPanel "ChangePort"
    elif test $[num] -eq 7; then
        optionPanel "lookasdefault"
    elif test $[num] -eq 8; then
        aboutPanelss
    else
        printf "已取消命令行工具！\n"
    fi
}

function commandFunction() {
    if [ "${command}" == "1" ]; then
        optionPanel "OpenPanel"
    elif [ "${command}" == "2" ]; then
        optionPanel "ClosePanel"
    elif [ "${command}" == "5" ]; then
        optionPanel "Uninstall"
    elif [ "${command}" == "6" ]; then
        optionPanel "ChangePort"
    elif [ "${command}" == "7" ]; then
        optionPanel "lookasdefault"
    elif [ "${command}" == "8" ]; then
        aboutPanelss
    else
        commandTools
    fi
}

commandFunction