 #!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH && LANG=en_US.UTF-8
export ToolPath=$( base64 -d <<< L3Vzci9iaW4vdGltZXh0b29s )

Red_Error() {
	installlog "$@" > /dev/null 2>&1 && printf '\033[1;31;10m%b\033[0m\n' "$@";
}

Warn_Error() {
	installlog "$@" > /dev/null 2>&1 && printf '\033[1;33;10m%b\033[0m\n' "$@";
}

Black_Error() {
	installlog "$@" > /dev/null 2>&1 && printf '\033[1;30;10m%b\033[0m\n' "$@";
}

Green_Error() {
	installlog "$@" > /dev/null 2>&1 && printf '\033[1;36;10m%b\037[0m\n' "$@";
}

White_Error() {
	installlog "$@" > /dev/null 2>&1 && printf '\033[1;33;10m%b\033[0m\n' "$@";
}

Notice_Error() {
    installlog "$@" > /dev/null 2>&1 && printf '\033[1;34;10m%b\033[0m\n' "$@";
}

Purple_Error() {
    installlog "$@" > /dev/null 2>&1 && printf '\033[1;35;10m%b\033[0m\n' "$@";
}

Success_Error() {
	installlog "$@" > /dev/null 2>&1 && printf '\033[1;32;10m%b\033[0m\n' "$@";
}

IRed_Error() {
	installlog "$@" > /dev/null 2>&1 && printf '\033[1;31;10m%b\033[0m' "$@";
}

IWarn_Error() {
	installlog "$@" > /dev/null 2>&1 && printf '\033[1;33;10m%b\033[0m' "$@";
}

IBlack_Error() {
	installlog "$@" > /dev/null 2>&1 && printf '\033[1;30;10m%b\033[0m' "$@";
}

IGreen_Error() {
	installlog "$@" > /dev/null 2>&1 && printf '\033[1;36;10m%b\037[0m' "$@";
}

Ihite_Error() {
	installlog "$@" > /dev/null 2>&1 && printf '\033[1;33;10m%b\033[0m' "$@";
}

INotice_Error() {
    installlog "$@" > /dev/null 2>&1 && printf '\033[1;34;10m%b\033[0m' "$@";
}

IPurple_Error() {
    installlog "$@" > /dev/null 2>&1 && printf '\033[1;35;10m%b\033[0m' "$@";
}

ISuccess_Error() {
	installlog "$@" > /dev/null 2>&1 && printf '\033[1;32;10m%b\033[0m' "$@";
}

if [ $(whoami) != "root" ];then
	Red_Error "请使用ROOT权限执行TIMEX TOOL安装命令！" && exit 1
fi

function installlog() {
    if [ "$2" != "none" ]; then
        echo "$1" && message="[$(date | awk 'NR==1{print $4}') Install Log]: $1 "
    fi
    echo "${message}" >> ${ToolPath}/panel/cache/install.log
}

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

install=$( base64 -d <<< MS4xLjUtQmV0YQ== )

function checkInstall() {
    export panelver=$(cat ${ToolPath}/panel/cache/panel.ver | awk 'NR==1{print $1}')
    if [ "$panelver" == "PanelFalse" ]; then
        startInstall
    elif [ "$panelver" == "PanelTrue" ]; then
        Red_Error "\n检测到该设备已经安装，请勿重复安装!\n"
    else
        Red_Error "\n安装过程发生异常，或是没有权限导致!\n"
    fi
}

protext="— 正在准备下载面板文件 —"

function startInstall() {
    printf "\n"
    echo -n "是否安装TimeX Panel面板（Y/N）：" && read ask_install
    if [ "$ask_install" == "Y" ] || [ "$ask_install" == "y" ]; then
        sleep 0.5 && progress="0"
        panelport=$(cat ${ToolPath}/panel/cache/panel.ver | awk 'NR==1{print $3}')
        cd ${ToolPath}/panel && export http_head=$( base64 -d <<< aHR0cHM6Ly90aW1leC55dW5haXIuY24= )
        export http_file=$( base64 -d <<< L3lpY2hlbjkyNDcvdGltZXh0b29sL3ppcC9UaW1lWFBhbmVsLnppcA== )
        progress="1" && printfprogres "${progress}"
            if [ -f /usr/bin/curl ]; then 
                curl -sSO ${http_head}${http_file}
            else 
                local_url=$( base64 -d <<< L3Vzci9iaW4vdGltZXh0b29sL3BhbmVsL1RpbWVYUGFuZWwuemlw )
                wget -O ${local_url} ${http_head}${http_file} -T 10
            fi;
        progress="2" && printfprogres "${progress}"
            chmod 777 TimeXPanel.zip && unzip -uq TimeXPanel.zip
        progress="3" && printfprogres "${progress}"
            sleep 0.5 && rm -rf TimeXPanel.zip
            checkInstalled yum
            if test $? -eq 0; then
                yum install -y docker > /dev/null 2>&1
            fi
            checkInstalled apt-get
            if test $? -eq 0; then
                curl -fsSL https://get.docker.com -o get-docker.sh > /dev/null 2>&1 && sudo sh get-docker.sh > /dev/null 2>&1
            fi
        progress="4" && printfprogres "${progress}"
            sleep 0.5 && cd /usr/bin/timextool/panel/TimeXPanel
            sudo systemctl start docker > /dev/null 2>&1
            sudo chmod 777 /var/run/docker.sock > /dev/null 2>&1
            echo "FROM nginx:latest" >> Dockerfile && echo "COPY / /usr/share/nginx/html" >> Dockerfile
        progress="5" && printfprogres "${progress}"
            sleep 0.5 && docker build -t timexpanel . > /dev/null 2>&1
        progress="6" && printfprogres "${progress}"
            sleep 0.5 && registProfile > /dev/null 2>&1
        progress="7" && printfprogres "${progress}"
            sleep 0.5 && sudo systemctl enable docker > /dev/null 2>&1
        progress="8" && printfprogres "${progress}"
            sleep 0.5 && docker run -d -p ${panelport}:80 timexpanel > /dev/null 2>&1
        progress="9" && printfprogres "${progress}"
            sleep 0.5 && completeStart
    else
        installlog "已取消安装TimeX Panel！\n"
    fi
}

function printfprogres() {
    allprot="\9" && printf "\n"
    if [ "$1" == "1" ]; then
        printf "\n" && installlog "— 正在开始下载面板文件 —" "none"
        printf "[%s%s] [%s]\r" "$1" "${allprot}" "${protext}"  && protext="— 正在开始下载面板文件 —"
    elif [ "$1" == "2" ]; then
        printf "\n" && installlog "— 正在开始解压面板文件 —" "none"
        printf "[%s%s] [%s]\r" "$1" "${allprot}" "${protext}"  && protext="— 正在开始解压面板文件 —"
    elif [ "$1" == "3" ]; then
        printf "\n" && installlog "— 正在开始准备容器文件 —" "none"
        printf "[%s%s] [%s]\r" "$1" "${allprot}" "${protext}"  && protext="— 正在开始准备容器文件 —"
    elif [ "$1" == "4" ]; then
        printf "\n" && installlog "— 正在开始创建配置文件 —" "none"
        printf "[%s%s] [%s]\r" "$1" "${allprot}" "${protext}"  && protext="— 正在开始创建配置文件 —"
    elif [ "$1" == "5" ]; then
        printf "\n" && installlog "— 正在开始创建面板容器 —" "none"
        printf "[%s%s] [%s]\r" "$1" "${allprot}" "${protext}"  && protext="— 正在开始创建面板容器 —"
    elif [ "$1" == "6" ]; then
        printf "\n" && installlog "— 正在开始配置命令模块 —" "none"
        printf "[%s%s] [%s]\r" "$1" "${allprot}" "${protext}"  && protext="— 正在开始配置命令模块 —"
    elif [ "$1" == "7" ]; then
        printf "\n" && installlog "— 正在设置面板开机自启 —" "none"
        printf "[%s%s] [%s]\r" "$1" "${allprot}" "${protext}"  && protext="— 正在设置面板开机自启 —"
    elif [ "$1" == "8" ]; then
        printf "\n" && installlog "— 正在开始启动面板容器 —" "none"
        printf "[%s%s] [%s]\r" "$1" "${allprot}" "${protext}"  && protext="— 正在开始启动面板容器 —"
    elif [ "$1" == "9" ]; then
        printf "\n" && installlog "— 面板容器安装启动成功 —" "none"
        printf "[%s%s] [%s]\r" "$1" "${allprot}" "${protext}"  && protext="— 面板容器安装启动成功 —"
    fi
}

function registProfile() {
    cd ${ToolPath}/panel && export http_head=$( base64 -d <<< aHR0cHM6Ly90aW1leC55dW5haXIuY24= )
    export http_file=$( base64 -d <<< L3lpY2hlbjkyNDcvdGltZXh0b29sL3NoL1BhbmVsL3BhbmVsYmFzaC5zaA== )
    if [ -f /usr/bin/curl ]; then 
        curl -sSO ${http_head}${http_file}
    else 
        local_url=$( base64 -d <<< L3Vzci9iaW4vdGltZXh0b29sL3BhbmVsL3BhbmVsYmFzaC5zaA== )
        wget -O ${local_url} ${http_head}${http_file} -T 10
    fi;
    sleep 0.5 && createCommand
}

function createCommand() {
    sleep 0.5 && cd ${ToolPath}/panel
    mv -f panelbash.sh xctl && mv -f ${ToolPath}/panel/xctl /usr/local/bin/xctl
    sleep 0.5 && chmod 777 /usr/local/bin/xctl && chown root /usr/local/bin/xctl
}

function completeStart() {
    printf "\n" && printf "\n"
    export icaddress=$(hostname -I | awk 'NR==1{print $1}')
    export ipaddress=$(curl -s https://api.bt.cn/api/getipaddress)
    panelport=$(cat ${ToolPath}/panel/cache/panel.ver | awk 'NR==1{print $3}')
    installlog "===============时光控制台程序=================="
    printf "\n"
    
    installlog " - 内网访问地址：http://${icaddress}:${panelport}"
    installlog " - "
    installlog " - 外网访问地址：http://${ipaddress}:${panelport}"
    
    printf "\n"
    installlog "==============================================="
    echo "PanelTrue Open ${panelport}" > ${ToolPath}/panel/cache/panel.ver
    printf "\n" && Success_Error "已成功安装TimeX Panel，执行命令【xctl】开始使用！\n"
}

function dostartUpdate() {
    checkInstalled yum
    if test $? -eq 0; then
        installStart
    else
        checkInstalled apt-get
        if test $? -eq 0; then
            installStart
        else
            Red_Error "暂不支持除CentOS/Ubuntu以外的操作系统安装！"
        fi
    fi
}

function installStart() {
    if [ ! -d "${ToolPath}" ]; then
        mkdir ${ToolPath}
        chmod 777 ${ToolPath} && chown root ${ToolPath}
    fi
    
    if [ ! -d "${ToolPath}/cache" ]; then
        mkdir ${ToolPath}/cache
        chmod 777 ${ToolPath}/cache && chown root ${ToolPath}/cache
    fi
    
    if [ ! -d "${ToolPath}/panel" ]; then
        mkdir ${ToolPath}/panel
        chmod 777 ${ToolPath}/panel && chown root ${ToolPath}/panel
    fi
    
    if [ ! -d "${ToolPath}/panel/cache" ]; then
        mkdir ${ToolPath}/panel/cache
        chmod 777 ${ToolPath}/panel/cache && chown root ${ToolPath}/panel/cache
    fi
    
    if [ ! -e "${ToolPath}/panel/cache/panel.ver" ]; then
        touch ${ToolPath}/panel/cache/panel.ver && echo "PanelFalse Close 6099" >> ${ToolPath}/panel/cache/panel.ver
        chmod 777 ${ToolPath}/panel/cache/panel.ver && chown root ${ToolPath}/panel/cache/panel.ver
    fi
    
    if [ ! -e "${ToolPath}/panel/cache/install.log" ]; then
        touch ${ToolPath}/panel/cache/install.log
        chmod 777 ${ToolPath}/panel/cache/install.log && chown root ${ToolPath}/panel/cache/install.log
    fi
    
    printf "\n" && sleep 0.5
    chmod 777 toolpanel.sh
    installlog "Install Version ${install}"
}

dostartUpdate && checkInstall