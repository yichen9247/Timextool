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

export toolVersion=$( base64 -d <<< MS4xLjUtQmV0YQ== )

function installlog() {
    if [ "$2" != "none" ]; then
        echo "$1" && message="[$(date | awk 'NR==1{print $4}') Install Log]: $1 "
    fi
    echo "${message}" >> /usr/bin/timextool/panel/cache/install.log
}

function checkInstalled() {
    type $1 > /dev/null 2>&1
    if test $? -eq 1; then
        return 1
    else
        return 0
    fi
}

function installlog() {
    echo "$1" && message="[$(date | awk 'NR==1{print $4}') Install Log]: $1 "
    echo "${message}" >> ${ToolPath}/cache/install.log
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

function startInstallTool_V() {
    printf "\n"
    echo -n "是否安装TIMEX TOOL FOR Java（Y/N）：" && read ask_install
    if [ "$ask_install" == "Y" ] || [ "$ask_install" == "y" ]; then
        cd ${ToolPath} && export http_head=$( base64 -d <<< aHR0cHM6Ly90aW1leC55dW5haXIuY24= )
        if [ ! -d "${ToolPath}/Java" ]; then
            mkdir ${ToolPath}/Java
            chmod 777 ${ToolPath}/Java && chown root ${ToolPath}/Java
        fi
        cd ${ToolPath}/Java && sleep 0.5
        export http_file=$( base64 -d <<< L3lpY2hlbjkyNDcvdGltZXh0b29sL3NoL0phdmEvbGludXh0b29sLmphdmE= )
        if [ -f /usr/bin/curl ]; then 
            curl -sSO ${http_head}${http_file}
        else 
            local_url=$( base64 -d <<< L3Vzci9iaW4vdGltZXh0b29sL0phdmEvbGludXh0b29sLmphdmE= ) && wget -O ${local_url} ${http_head}${http_file} -T 10
        fi;
        printf "\n"
        checkInstalled java
        if test $? -eq 1; then
            Red_Error "请先安装必要环境Java！" && exit 1;
        fi
        checkInstalled javac
        if test $? -eq 1; then
            Red_Error "正在安装必要环境Javac！" && printf "\n";
            checkInstalled yum
            if test $? -eq 0; then
                sudo yum update
                yum install java-devel
            fi
            checkInstalled apt-get
            if test $? -eq 0; then
                sudo apt-get install java-devel
            fi
        fi
        javac linuxtool.java && sleep 0.5
        curl -o /etc/yum.repos.d/konimex-neofetch-epel-7.repo https://copr.fedorainfracloud.org/coprs/konimex/neofetch/repo/epel-7/konimex-neofetch-epel-7.repo
        sleep 0.5 && printf "\n"
        chmod 777 ${ToolPath}/Java/linuxtool.class && chown root ${ToolPath}/linuxtool.class && doLastInstall "FOR-V"
        rm -rf ${ToolPath}/Java/linuxtool.java && Success_Error "已成功安装TIMEX TOOL FOR Java，执行命令【timev】开始使用！\n"
    else
        installlog "已取消安装TIMEX TOOL FOR Java！\n"
    fi
}

function startUpdateTool_V() {
    printf "\n"
    echo -n "是否升级TIMEX TOOL FOR Java（Y/N）：" && read ask_update
    if [ "$ask_update" == "Y" ] || [ "$ask_update" == "y" ]; then
        sleep 0.5 && export http_head=$( base64 -d <<< aHR0cHM6Ly90aW1leC55dW5haXIuY24= )
        if [ ! -d "${ToolPath}/Java" ]; then
            mkdir ${ToolPath}/Java
            chmod 777 ${ToolPath}/Java && chown root ${ToolPath}/Java
        fi
        cd ${ToolPath}/Java && sleep 0.5
        export http_file=$( base64 -d <<< L3lpY2hlbjkyNDcvdGltZXh0b29sL3NoL0phdmEvbGludXh0b29sLmphdmE= )
        if [ -f /usr/bin/curl ]; then 
            curl -sSO ${http_head}${http_file}
        else 
            local_url=$( base64 -d <<< L3Vzci9iaW4vdGltZXh0b29sL0phdmEvbGludXh0b29sLmphdmE= ) && wget -O ${local_url} ${http_head}${http_file} -T 10
        fi;
        printf "\n" && sleep 0.5
        checkInstalled java
        if test $? -eq 1; then
            Red_Error "请先安装必要环境Java！" && exit 1;
        fi
        checkInstalled javac
        if test $? -eq 1; then
            Red_Error "正在安装必要环境Javac！" && printf "\n";
            checkInstalled yum
            if test $? -eq 0; then
                sudo yum update
                yum install java-devel
            fi
            checkInstalled apt-get
            if test $? -eq 0; then
                sudo apt-get install java-devel
            fi
        fi
        javac linuxtool.java && curl -o /etc/yum.repos.d/konimex-neofetch-epel-7.repo https://copr.fedorainfracloud.org/coprs/konimex/neofetch/repo/epel-7/konimex-neofetch-epel-7.repo
        sleep 0.5 && printf "\n"
        chmod 777 ${ToolPath}/Java/linuxtool.class && chown root ${ToolPath}/linuxtool.class && doLastInstall "FOR-V"
        rm -rf ${ToolPath}/Java/linuxtool.java && Success_Error "已成功升级TIMEX TOOL FOR Java，执行命令【timev】开始使用！\n"
    else
        installlog "已取消升级TIMEX TOOL FOR Java！\n"
    fi
}

function startInstallTool_P() {
    printf "\n"
    echo -n "是否安装TIMEX TOOL FOR Python（Y/N）：" && read ask_install
    if [ "$ask_install" == "Y" ] || [ "$ask_install" == "y" ]; then
        cd ${ToolPath} && export http_head=$( base64 -d <<< aHR0cHM6Ly90aW1leC55dW5haXIuY24= )
        if [ ! -d "${ToolPath}/Python" ]; then
            mkdir ${ToolPath}/Python
            chmod 777 ${ToolPath}/Python && chown root ${ToolPath}/Python
        fi
        cd ${ToolPath}/Python && sleep 0.5
        export http_file=$( base64 -d <<< L3lpY2hlbjkyNDcvdGltZXh0b29sL3NoL1B5dGhvbi9saW51eHRvb2wucHk= )
        if [ -f /usr/bin/curl ]; then 
            curl -sSO ${http_head}${http_file}
        else 
            local_url=$( base64 -d <<< L3Vzci9iaW4vdGltZXh0b29sL1B5dGhvbi9saW51eHRvb2wucHk= ) && wget -O ${local_url} ${http_head}${http_file} -T 10
        fi;
        printf "\n" && sleep 0.5
        curl -o /etc/yum.repos.d/konimex-neofetch-epel-7.repo https://copr.fedorainfracloud.org/coprs/konimex/neofetch/repo/epel-7/konimex-neofetch-epel-7.repo
        sleep 0.5 && printf "\n"
        chmod 777 ${ToolPath}/Python/linuxtool.py && chown root ${ToolPath}/Python/linuxtool.py
        checkInstalled python3
        if test $? -eq 1; then
            printf "\n"
            installlog "正在安装必要环境Python3！" && printf "\n"
            if [ ! -d "/usr/local/Python3" ]; then
                mkdir /usr/local/Python3
            fi
            wget https://www.python.org/ftp/python/3.7.6/Python-3.7.6.tgz && tar -zxvf Python-3.7.6.tgz
            checkInstalled yum
            if test $? -eq 1; then
                yum -y install gcc
                yum -y install zlib* && yum install readline-devel
                sleep 0.5 && cd Python-3.7.6
                ./configure --prefix=/usr/local/python3
                make && make install
                ln -s /usr/local/python3/bin/python3.7 /usr/bin/python3
            fi
            checkInstalled apt-get
            if test $? -eq 1; then
                yum -y install gcc
                yum -y install zlib* && yum install readline-devel
                sleep 0.5 && cd Python-3.7.6
                LDFLAGS="-L/usr/lib/x86_64-linux-gnu" ./configure
                make && sudo make install
            fi
            sudo pip3 install --upgrade pip
            pip3 install requests && rm -rf Python-3.7.6.tgz
            checkInstalled python3
            if test $? -eq 1; then
                Red_Error "错误，在您的系统上安装必要环境[Python]失败！"
            else:
                Success_Error "已成功在您的系统上安装软件[Python]！"
            fi
        fi
        doLastInstall "FOR-P" && Success_Error "已成功安装TIMEX TOOL FOR Python，执行命令【timep】开始使用！\n"
    else
        installlog "已取消安装TIMEX TOOL FOR Python！\n"
    fi
}

function startUpdateTool_P() {
    printf "\n"
    echo -n "是否升级TIMEX TOOL FOR Python（Y/N）：" && read ask_update
    if [ "$ask_update" == "Y" ] || [ "$ask_update" == "y" ]; then
        sleep 0.5 && export http_head=$( base64 -d <<< aHR0cHM6Ly90aW1leC55dW5haXIuY24= )
        cd ${ToolPath} && export http_head=$( base64 -d <<< aHR0cHM6Ly90aW1leC55dW5haXIuY24= )
        if [ ! -d "${ToolPath}/Python" ]; then
            mkdir ${ToolPath}/Python
            chmod 777 ${ToolPath}/Python && chown root ${ToolPath}/Python
        fi
        cd ${ToolPath}/Python && sleep 0.5
        export http_file=$( base64 -d <<< L3lpY2hlbjkyNDcvdGltZXh0b29sL3NoL1B5dGhvbi9saW51eHRvb2wucHk= )
        if [ -f /usr/bin/curl ]; then 
            curl -sSO ${http_head}${http_file}
        else 
            local_url=$( base64 -d <<< L3Vzci9iaW4vdGltZXh0b29sL1B5dGhvbi9saW51eHRvb2wucHk= ) && wget -O ${local_url} ${http_head}${http_file} -T 10
        fi;
        printf "\n" && sleep 0.5
        curl -o /etc/yum.repos.d/konimex-neofetch-epel-7.repo https://copr.fedorainfracloud.org/coprs/konimex/neofetch/repo/epel-7/konimex-neofetch-epel-7.repo
        sleep 0.5 && printf "\n"
        chmod 777 ${ToolPath}/Python/linuxtool.py && chown root ${ToolPath}/Python/linuxtool.py
        checkInstalled python3
        if test $? -eq 1; then
            printf "\n"
            installlog "正在安装必要环境Python3！" && printf "\n"
            if [ ! -d "/usr/local/Python3" ]; then
                mkdir /usr/local/Python3
            fi
            wget https://www.python.org/ftp/python/3.7.6/Python-3.7.6.tgz && tar -zxvf Python-3.7.6.tgz
            checkInstalled yum
            if test $? -eq 1; then
                yum -y install gcc
                yum -y install zlib*
                yum install readline-devel
                sleep 0.5 && cd Python-3.7.6
                ./configure --prefix=/usr/local/python3
                make && make install
                ln -s /usr/local/python3/bin/python3.7 /usr/bin/python3
            fi
            checkInstalled apt-get
            if test $? -eq 1; then
                yum -y install gcc
                yum -y install zlib*
                yum install readline-devel
                sleep 0.5 && cd Python-3.7.6
                LDFLAGS="-L/usr/lib/x86_64-linux-gnu" ./configure
                make && sudo make install
            fi
            sudo pip3 install --upgrade pip
            pip3 install requests && rm -rf Python-3.7.6.tgz
            checkInstalled python3
            if test $? -eq 1; then
                Red_Error "错误，在您的系统上安装必要环境[Python]失败！"
            else:
                Success_Error "已成功在您的系统上安装软件[Python]！"
            fi
        fi
        doLastInstall "FOR-P" && Success_Error "已成功升级TIMEX TOOL FOR Python，执行命令【timep】开始使用！\n"
    else
        installlog "已取消升级TIMEX TOOL FOR Python！\n"
    fi
}

function startInstallTool_C1() {
    printf "\n"
    echo -n "是否安装TIMEX TOOL FOR C++（Y/N）：" && read ask_install
    if [ "$ask_install" == "Y" ] || [ "$ask_install" == "y" ]; then
        cd ${ToolPath} && export http_head=$( base64 -d <<< aHR0cHM6Ly90aW1leC55dW5haXIuY24= )
        if [ ! -d "${ToolPath}/C++" ]; then
            mkdir ${ToolPath}/C++
            chmod 777 ${ToolPath}/C++ && chown root ${ToolPath}/C++
        fi
        cd ${ToolPath}/C++ && sleep 0.5
        export http_file=$( base64 -d <<< L3lpY2hlbjkyNDcvdGltZXh0b29sL3NoL2xpbnV4dG9vbA== )
        if [ -f /usr/bin/curl ]; then 
            curl -sSO ${http_head}${http_file}
        else 
            local_url=$( base64 -d <<< L3Vzci9iaW4vdGltZXh0b29sL0MrKy9saW51eHRvb2w= ) && wget -O ${local_url} ${http_head}${http_file} -T 10
        fi;
        printf "\n" && sleep 0.5
        curl -o /etc/yum.repos.d/konimex-neofetch-epel-7.repo https://copr.fedorainfracloud.org/coprs/konimex/neofetch/repo/epel-7/konimex-neofetch-epel-7.repo
        sleep 0.5 && printf "\n"
        chmod 777 ${ToolPath}/C++/linuxtool && chown root ${ToolPath}/C++/linuxtool
        doLastInstall "FOR-C2" && Success_Error "已成功安装TIMEX TOOL FOR C++，执行命令【timex】开始使用！\n"
    else
        installlog "已取消安装TIMEX TOOL FOR C++！\n"
    fi
}

function startUpdateTool_C1() {
    printf "\n"
    echo -n "是否升级TIMEX TOOL FOR C++（Y/N）：" && read ask_update
    if [ "$ask_update" == "Y" ] || [ "$ask_update" == "y" ]; then
        sleep 0.5 && export http_head=$( base64 -d <<< aHR0cHM6Ly90aW1leC55dW5haXIuY24= )
        if [ ! -d "${ToolPath}/C++" ]; then
            mkdir ${ToolPath}/C++
            chmod 777 ${ToolPath}/C++ && chown root ${ToolPath}/C++
        fi
        cd ${ToolPath}/C++ && sleep 0.5
        export http_file=$( base64 -d <<< L3lpY2hlbjkyNDcvdGltZXh0b29sL3NoL0MvbGludXh0b29s )
        if [ -f /usr/bin/curl ]; then 
            curl -sSO ${http_head}${http_file}
        else 
            local_url=$( base64 -d <<< L3Vzci9iaW4vdGltZXh0b29sL0MrKy9saW51eHRvb2w= ) && wget -O ${local_url} ${http_head}${http_file} -T 10
        fi;
        printf "\n" && sleep 0.5
        curl -o /etc/yum.repos.d/konimex-neofetch-epel-7.repo https://copr.fedorainfracloud.org/coprs/konimex/neofetch/repo/epel-7/konimex-neofetch-epel-7.repo
        sleep 0.5 && printf "\n"
        chmod 777 ${ToolPath}/C++/linuxtool && chown root ${ToolPath}/C++/linuxtool
        doLastInstall "FOR-C1" && Success_Error "已成功升级TIMEX TOOL FOR C++，执行命令【timeX】开始使用！\n"
    else
        installlog "已取消升级TIMEX TOOL FOR C++！\n"
    fi
}

function startInstallTool_C2() {
    printf "\n"
    echo -n "是否安装TIMEX TOOL FOR C（Y/N）：" && read ask_install
    if [ "$ask_install" == "Y" ] || [ "$ask_install" == "y" ]; then
        cd ${ToolPath} && export http_head=$( base64 -d <<< aHR0cHM6Ly90aW1leC55dW5haXIuY24= )
        if [ ! -d "${ToolPath}/C" ]; then
            mkdir ${ToolPath}/C++
            chmod 777 ${ToolPath}/C && chown root ${ToolPath}/C
        fi
        cd ${ToolPath}/C && sleep 0.5
        export http_file=$( base64 -d <<< L3lpY2hlbjkyNDcvdGltZXh0b29sL3NoL0MvbGludXh0b29s )
        if [ -f /usr/bin/curl ]; then 
            curl -sSO ${http_head}${http_file}
        else 
            local_url=$( base64 -d <<< L3Vzci9iaW4vdGltZXh0b29sL0MvbGludXh0b29s ) && wget -O ${local_url} ${http_head}${http_file} -T 10
        fi;
        printf "\n" && sleep 0.5
        curl -o /etc/yum.repos.d/konimex-neofetch-epel-7.repo https://copr.fedorainfracloud.org/coprs/konimex/neofetch/repo/epel-7/konimex-neofetch-epel-7.repo
        sleep 0.5 && printf "\n"
        chmod 777 ${ToolPath}/C/linuxtool && chown root ${ToolPath}/C/linuxtool
        doLastInstall "FOR-C2" && Success_Error "已成功安装TIMEX TOOL FOR C，执行命令【timex】开始使用！\n"
    else
        installlog "已取消安装TIMEX TOOL FOR C！\n"
    fi
}

function startUpdateTool_C2() {
    printf "\n"
    echo -n "是否升级TIMEX TOOL FOR C（Y/N）：" && read ask_update
    if [ "$ask_update" == "Y" ] || [ "$ask_update" == "y" ]; then
        sleep 0.5 && export http_head=$( base64 -d <<< aHR0cHM6Ly90aW1leC55dW5haXIuY24= )
        if [ ! -d "${ToolPath}/C" ]; then
            mkdir ${ToolPath}/C
            chmod 777 ${ToolPath}/C && chown root ${ToolPath}/C
        fi
        cd ${ToolPath}/C && sleep 0.5
        export http_file=$( base64 -d <<< L3lpY2hlbjkyNDcvdGltZXh0b29sL3NoL0MvbGludXh0b29s )
        if [ -f /usr/bin/curl ]; then 
            curl -sSO ${http_head}${http_file}
        else 
            local_url=$( base64 -d <<< L3Vzci9iaW4vdGltZXh0b29sL0MvbGludXh0b29s ) && wget -O ${local_url} ${http_head}${http_file} -T 10
        fi;
        printf "\n" && sleep 0.5
        curl -o /etc/yum.repos.d/konimex-neofetch-epel-7.repo https://copr.fedorainfracloud.org/coprs/konimex/neofetch/repo/epel-7/konimex-neofetch-epel-7.repo
        sleep 0.5 && printf "\n"
        chmod 777 ${ToolPath}/C/linuxtool && chown root ${ToolPath}/C/linuxtool
        doLastInstall "FOR-C2" && Success_Error "已成功升级TIMEX TOOL FOR C，执行命令【timeX】开始使用！\n"
    else
        installlog "已取消升级TIMEX TOOL FOR C！\n"
    fi
}

function startInstallTool() {
    printf "\n"
    echo -n "是否安装TIMEX TOOL工具（Y/N）：" && read ask_install
    if [ "$ask_install" == "Y" ] || [ "$ask_install" == "y" ]; then
        cd ${ToolPath} && export http_head=$( base64 -d <<< aHR0cHM6Ly90aW1leC55dW5haXIuY24= )
        if [ ! -d "${ToolPath}/Bash" ]; then
            mkdir ${ToolPath}/Bash
            chmod 777 ${ToolPath}/Bash && chown root ${ToolPath}/Bash
        fi
        cd ${ToolPath}/Bash && sleep 0.5
        export http_file=$( base64 -d <<< L3lpY2hlbjkyNDcvdGltZXh0b29sL3NoL0Jhc2gvbGludXh0b29sLnNo )
        if [ -f /usr/bin/curl ]; then 
            curl -sSO ${http_head}${http_file}
        else 
            local_url=$( base64 -d <<< L3Vzci9iaW4vdGltZXh0b29sL0Jhc2gvbGludXh0b29sLnNo )
            wget -O ${local_url} ${http_head}${http_file} -T 10
        fi;
        printf "\n" && sleep 0.5
        curl -o /etc/yum.repos.d/konimex-neofetch-epel-7.repo https://copr.fedorainfracloud.org/coprs/konimex/neofetch/repo/epel-7/konimex-neofetch-epel-7.repo
        sleep 0.5 && printf "\n"
        chmod 777 ${ToolPath}/Bash/linuxtool.sh && chown root ${ToolPath}/Bash/linuxtool.sh
        doLastInstall "FOR-S" && Success_Error "已成功安装TIMEX TOOL，执行命令【timex】开始使用！\n"
    else
        installlog "已取消安装TIMEX TOOL！\n"
    fi
}

function startUpdateTool() {
    printf "\n"
    echo -n "是否升级TIMEX TOOL工具（Y/N）：" && read ask_update
    if [ "$ask_update" == "Y" ] || [ "$ask_update" == "y" ]; then
        cd ${ToolPath} && export http_head=$( base64 -d <<< aHR0cHM6Ly90aW1leC55dW5haXIuY24= )
        if [ ! -d "${ToolPath}/Bash" ]; then
            mkdir ${ToolPath}/Bash
            chmod 777 ${ToolPath}/Bash && chown root ${ToolPath}/Bash
        fi
        cd ${ToolPath}/Bash && sleep 0.5
        export http_file=$( base64 -d <<< L3lpY2hlbjkyNDcvdGltZXh0b29sL3NoL0Jhc2gvbGludXh0b29sLnNo )
        if [ -f /usr/bin/curl ]; then 
            curl -sSO ${http_head}${http_file}
        else 
            local_url=$( base64 -d <<< L3Vzci9iaW4vdGltZXh0b29sL0Jhc2gvbGludXh0b29sLnNo ) && wget -O ${local_url} ${http_head}${http_file} -T 10
        fi;
        printf "\n" && sleep 0.5
        curl -o /etc/yum.repos.d/konimex-neofetch-epel-7.repo https://copr.fedorainfracloud.org/coprs/konimex/neofetch/repo/epel-7/konimex-neofetch-epel-7.repo && sleep 0.5
        chmod 777 ${ToolPath}/Bash/linuxtool.sh && chown root ${ToolPath}/Bash/linuxtool.sh
        doLastInstall "FOR-S" && Success_Error "已成功升级TIMEX TOOL，执行命令【timex】开始使用！\n"
    else
        installlog "已取消升级TIMEX TOOL！\n"
    fi
}

install=$( base64 -d <<< MS4xLjUtQmV0YQ== )
filename=$(basename "$0") && filebase=$( base64 -d <<< aW5zdGFsbC5zaA== )
if [ "$filename" != "$filebase" ]; then
    printf "\n" && Red_Error "签名验证失败，文件名被修改！"
    printf "\n" && exit 1
fi

function doLastInstall() {
    printf "\n" && export localver=$(cat ${ToolPath}/cache/timex.ver | awk 'NR==1{print $1}')
    export tool_file=$( base64 -d <<< L3lpY2hlbjkyNDcvdGltZXh0b29sL3NoL3Rvb2xjaGVjay5zaA== )
    if [ -f /usr/bin/curl ]; then 
        cd ${ToolPath} && curl -sSO ${http_head}${tool_file}
    else 
        cd ${ToolPath} && check_url=$( base64 -d <<< L3Vzci9iaW4vdGltZXh0b29sL3Rvb2xjaGVjay5zaA== ) && wget -O ${check_url} ${http_head}${tool_file} -T 10
    fi;
    sleep 0.5 && progress=""
    for ((ratio=0;${ratio}<=100;ratio+=5))
    do
        sleep 0.1
        printf "[%-80s][%d%%]\r" "${progress}" "${ratio}" && progress="====${progress}"
    done
    echo
    sleep 0.5 && createCommand
    sudo rm -rf install.sh > /dev/null 2>&1 && export localver=docheckUpdate.localver
    echo "${toolVersion} $1" > ${ToolPath}/cache/timex.ver && printf "\n"
}

function createCommand() {
    sleep 0.5 && cd ~/
    checkInstalled timex
    if test $? -eq 1; then
        sleep 0.5 && cd ${ToolPath}
        mv -f toolcheck.sh timex && mv -f ${ToolPath}/timex /usr/local/bin/timex
        sleep 0.5 && chmod 777 /usr/local/bin/timex && chown root /usr/local/bin/timex
    else
        sleep 0.5 && rm -rf ${ToolPath}/toolcheck.sh > /dev/null 2>&1
    fi
}

function docheckUpdate() {
    export localver=$(cat ${ToolPath}/cache/timex.ver | awk 'NR==1{print $1}')
    export timexver=$(cat ${ToolPath}/cache/timex.ver  | awk 'NR==1{print $2}')
    checkInstalled timex
    if test $? -eq 0; then
        if [ "$timexver" == "FOR-N" ]; then
        sleep 1 && selecedInstall
        elif [ "$timexver" == "FOR-S" ]; then
            sleep 1 && startUpdateTool
        elif [ "$timexver" == "FOR-C1" ]; then
            sleep 1 && startUpdateTool_C1
        elif [ "$timexver" == "FOR-C2" ]; then
            sleep 1 && startUpdateTool_C2
        elif [ "$timexver" == "FOR-P" ]; then
            sleep 1 && startUpdateTool_P
        elif [ "$timexver" == "FOR-V" ]; then
            sleep 1 && startUpdateTool_V
        fi
    else
        selecedInstall
    fi
}

function selecedInstall() {
    printf "\n"
    echo "===============请选择安装版本=================="
    echo "  (1) TIMEX-TOOL"
    echo "  (2) TIMEX-TOOL-FOR-C"
    echo "  (3) TIMEX-TOOL-FOR-C++"
    echo "  (4) TIMEX-TOOL-FOR-Java"
    echo "  (5) TIMEX-TOOL-FOR-Python"
    echo "==============================================="
    echo -n "请输入版本编号：" && read ask_check_toolver
    if test $[ask_check_toolver] -eq 1; then
        sleep 1 && startInstallTool
    elif test $[ask_check_toolver] -eq 2; then
        sleep 1 && startInstallTool_C
    elif test $[ask_check_toolver] -eq 3; then
        sleep 1 && startInstallTool_V
    elif test $[ask_check_toolver] -eq 4; then
        sleep 1 && startInstallTool_P
    else
        printf "请输入正确的安装选项！\n"
    fi
}

function dostartUpdate() {
    checkInstalled yum
    if test $? -eq 0; then
        docheckUpdate
    else
        checkInstalled apt-get
        if test $? -eq 0; then
            docheckUpdate
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
    
    if [ ! -e "${ToolPath}/cache/timex.ver" ]; then
        touch ${ToolPath}/cache/timex.ver && echo "00.00.00 FOR-N" >> ${ToolPath}/cache/timex.ver
        chmod 777 ${ToolPath}/cache/timex.ver && chown root ${ToolPath}/cache/timex.ver
    fi
    
    if [ ! -e "${ToolPath}/cache/install.log" ]; then
        touch ${ToolPath}/cache/install.log
        chmod 777 ${ToolPath}/cache/install.log && chown root ${ToolPath}/cache/install.log
    fi
    
    chmod 777 install.sh && printf "\n"
    installlog "Install Version ${install}"
}

installStart && docheckUpdate