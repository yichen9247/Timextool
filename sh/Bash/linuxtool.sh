#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH && LANG=en_US.UTF-8
export ToolPath=$( base64 -d <<< L3Vzci9iaW4vdGltZXh0b29s )

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

export toolToken=$( base64 -d <<< eWljaGVuOTI0Nw== )
export toolVersion=$( base64 -d <<< MS4xLjUtQmV0YQ== )
export langVersion=$( base64 -d <<< QmFzaCBGb3IgMS4xLjU= )
export serverHttpHead=$( base64 -d <<< aHR0cHM6Ly90aW1leC55dW5haXIuY24= )
export serverHttpBody=$( base64 -d <<< L3lpY2hlbjkyNDcvdGltZXh0b29sL2FwaQ== )

function checkInstalled() {
    type $1 > /dev/null 2>&1
    if test $? -eq 1; then
        return 1
    else
        return 0
    fi
}

function vuepressBuild() {
    echo -n "[VuePress]使用NPM还是YARN（1/2）："
    read ask_vuepress_build
    if test $[ask_vuepress_build] -eq 1; then
        checkInstalled npm
        if test $? -eq 1; then
            Red_Error "请先安装NPM包管理器!"
        else    
            echo -n "[NPM]正在开始构建文章！"
            sleep 1 && printf "\n"
            npm vuepress build && printf "\n"
            Success_Error -n "[NPM]文章构建已经完成！"
        fi
    elif test $[ask_vuepress_build] -eq 2; then
        checkInstalled yarn
        if test $? -eq 1; then
            Red_Error "请先安装YARN包管理器!"
        else
            echo -n "[YARN]正在开始构建文章！"
            sleep 1 && printf "\n"
            yarn vuepress build && printf "\n"
            Success_Error -n "[YARN]文章构建已经完成！"
        fi
    else
        printf "请输入正确的选项编号！\n"
    fi
}

function installBtPanel() {
    checkInstalled bt
    if test $? -eq 1; then
        printf  "正在开始安装宝塔面板！\n"
        sleep 1
        if [ -f /usr/bin/curl ]; then 
            curl -sSO https://download.bt.cn/install/install_panel.sh
        else 
            wget -O install_panel.sh https://download.bt.cn/install/install_panel.sh
        fi;
        bash install_panel.sh ed8484bec
    else
        IWarn_Error "检测到当前系统已安装宝塔面板，是否覆盖安装（Y/N）："
        read ask_re_install_bt
        if [ "$ask_re_install_bt" == "Y" ] || [ "$ask_re_install_bt" == "y" ]; then
            printf  "正在开始安装宝塔面板！\n"
            sleep 1
            if [ -f /usr/bin/curl ]; then 
                curl -sSO https://download.bt.cn/install/install_panel.sh
            else 
                wget -O install_panel.sh https://download.bt.cn/install/install_panel.sh
            fi;
            bash install_panel.sh ed8484bec
        else
	        printf "已取消安装宝塔面板！\n"
	   fi
    fi
}

function installBtMirror() {
    checkInstalled btm
    if test $? -eq 1; then
        printf  "正在开始安装宝塔云监控！\n"
        sleep 1
        if [ -f /usr/bin/curl ]; then
            curl -sSO https://download.bt.cn/install/install_btmonitor.sh
        else
            wget -O install_btmonitor.sh https://download.bt.cn/install/install_btmonitor.sh
        fi
        bash install_btmonitor.sh
    else
        IWarn_Error "检测到当前系统已安装宝塔云监控，是否覆盖安装（Y/N）："
        read ask_re_install_btm
        if [ "$ask_re_install_btm" == "Y" ] || [ "$ask_re_install_btm" == "y" ]; then
            printf  "正在开始安装宝塔云监控！\n"
            sleep 1
            if [ -f /usr/bin/curl ]; then
                curl -sSO https://download.bt.cn/install/install_btmonitor.sh
            else
                wget -O install_btmonitor.sh https://download.bt.cn/install/install_btmonitor.sh
            fi
            bash install_btmonitor.sh
        else
	        printf "已取消安装宝塔云监控！\n"
	   fi
    fi
}

function downloadInternet() {
    if [ ! -d "/root/download/" ]; then
        mkdir /root/download
    fi
    cd /root/download && echo -n "请输入网络资源直链链接："
    read ask_download_url && wget $ask_download_url
    Success_Error "下载完成，请前往[/root/download/]查看！"
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

function shellShowConfig() {
    checkInstalled neofetch
    if test $? -eq 1; then
        sleep 0.5 && printf "正在安装相关依赖包！\n"
        checkInstalled yum
        if test $? -eq 0; then
            yum install -y dnf-plugins-core
            yum install -y epel-release
            yum install -y dnf
            sudo dnf copr enable konimex/neofetch && sudo dnf install neofetch
        fi
        checkInstalled apt-get
        if test $? -eq 0; then
            sudo add-apt-repository ppa:dawidd0811/neofetch
            sudo apt-get update.
            sudo apt-get install neofetch
        fi
        Success_Error "相关依赖包安装完成！" && printf "\n"
    fi
    printf "\n" && neofetch
}

function shellShowBrowser() {
    checkInstalled w3m
    if test $? -eq 1; then
        sleep 0.5 && printf "正在安装相关依赖包！\n"
        checkInstalled yum
        if test $? -eq 0; then
            yum install -y epel-release
            yum install -y w3m
            yum install -y ImageMagick
            yum install -y ImageMagick-devel
            yum -y install w3m w3m-inline-image
        fi
        checkInstalled apt-get
        if test $? -eq 0; then
            sudo apt-get install zhcon
            sudo apt-get install w3m-img
            sudo apt install imagemagick
            sudo apt install imagemagick-devel
        fi
        Success_Error "相关依赖包安装完成！"
    fi
    printf "\n"
    echo "===============简易浏览器应用=================="
    echo "  使用：请在下方输入你想要跳转的网站链接"
    echo "==============================================="
    echo -n "请输入网站链接："
    read ask_browser_url && w3m $ask_browser_url
}

function somegoogGames() {
    printf "\n"
    echo "===============休闲娱乐的游戏=================="
    
    echo "  (1) 托马斯的火车           (2) 一只可爱小狗"
    echo "  (3) 炫酷的代码雨           (4) 等待添加游戏"
    
    echo "==============================================="
    echo -n "请输入游戏编号："
    read ask_game_num
    if test $[ask_game_num] -eq 1; then
        checkInstalled sl
        if test $? -eq 1; then
            printf "正在安装相关依赖包！\n"
            checkInstalled yum
            if test $? -eq 0; then
                yum install -y sl
            fi
            checkInstalled apt-get
            if test $? -eq 0; then
                sudo apt-get install sl
            fi
            Success_Error "相关依赖包安装完成！"
        fi
        sl
    elif test $[ask_game_num] -eq 2; then
        checkInstalled boxes
        if test $? -eq 1; then
            printf "正在安装相关依赖包！\n"
            checkInstalled yum
            if test $? -eq 0; then
                yum install -y boxes
            fi
            checkInstalled apt-get
            if test $? -eq 0; then
                sudo apt-get install boxes
            fi
            Success_Error "相关依赖包安装完成！"
        fi
        echo "I am a dog" | boxes -d dog -a c
    elif test $[ask_game_num] -eq 3; then
        checkInstalled cmatrix
        if test $? -eq 1; then
            printf "正在安装相关依赖包！\n"
            checkInstalled yum
            if test $? -eq 0; then
                if [ ! -d "/usr/local/coderain/" ]; then
                    mkdir /usr/local/coderain
                fi
                cd /root/coderain
                wget https://jaist.dl.sourceforge.net/project/cmatrix/cmatrix/1.2a/cmatrix-1.2a.tar.gz && tar xf cmatrix-1.2a.tar.gz
                yum install ncurses-devel  -y
                yum install gcc  -y
                yum install gcc-c++  -y
                yum install make  -y
                printf "\n" && printf "正在删除不需要的包！\n"
                rm -rf cmatrix-1.2a.tar.gz
                cd cmatrix-1.2a/ && ./configure && make && make install
            else
                Red_Error "该游戏暂不支持除CentOS以外的操作系统！" && exit 1
            fi
            Success_Error "相关依赖包安装完成！"
        fi
        cmatrix
    elif test $[ask_game_num] -eq 4; then
        Success_Error "更多游戏敬请期待哦！"
    else
        printf "请输入正确的游戏编号！\n"
    fi
}

function aboutThisTools() {
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
    figlet TIMEX TOOL && printf "\n"
    echo "————————————————————————————————————————————————————————"
    echo "NAME: TIMEX TOOL"
    echo "AUTHOR: HUA"
    echo "VERSION：${toolVersion}"
    echo "DESCRIBE：A Linux script for an integrated utility"
    echo "————————————————————————————————————————————————————————"
}

function someSystemTools() {
    printf "\n"
    echo "===============建站运维的工具=================="
    
    echo "  (1) 系统监控工具           (2) 磁盘监控工具"
    echo "  (3) 查看磁盘情况           (4) 执行一键删库"
    echo "  (5) 查看流量监控           (6) 性能资源监控"
    echo "  (7) 简约文件管理           (8) 查看系统信息"
    
    echo "==============================================="
    echo -n "请输入工具编号：" && read ask_tool_num
    if test $[ask_tool_num] -eq 1; then
        checkInstalled htop
        if test $? -eq 1; then
            printf "正在安装相关依赖包！\n"
            checkInstalled yum
            if test $? -eq 0; then
                yum install -y epel-release && yum install -y htop
            fi
            checkInstalled apt-get
            if test $? -eq 0; then
                sudo apt-get install htop
            fi
            Success_Error "相关依赖包安装完成！"
        fi
        htop
    elif test $[ask_tool_num] -eq 2; then
        checkInstalled iotop
        if test $? -eq 1; then
            printf "正在安装相关依赖包！\n"
            checkInstalled yum
            if test $? -eq 0; then
                yum install -y epel-release && yum install -y iotop
            fi
            checkInstalled apt-get
            if test $? -eq 0; then
                sudo apt-get install iotop
            fi
            Success_Error "相关依赖包安装完成！"
        fi
        iotop
    elif test $[ask_tool_num] -eq 3; then
        checkInstalled ncdu
        if test $? -eq 1; then
            printf "正在安装相关依赖包！\n"
            checkInstalled yum
            if test $? -eq 0; then
                yum install -y epel-release && yum install -y ncdu
            fi
            checkInstalled apt-get
            if test $? -eq 0; then
                sudo apt-get install ncdu
            fi
            Success_Error "相关依赖包安装完成！"
        fi
        ncdu
    elif test $[ask_tool_num] -eq 4; then
        IWarn_Error "当前操作为危险操作，请输入以下文字【I agree to do these dangerous opetions】：" && read ask_dangous_options
        if [ "$ask_dangous_options" == "I agree to do these dangerous opetions" ]; then
            if [ $(whoami) != "root" ]; then
                Red_Error "请使用ROOT权限执行TIMEX TOOL删库命令！" && exit 1;
            fi
            Success_Error "验证成功，即将在十秒钟后执行删库，在这期间可用【Ctrl + C】撤销操作！" && countdown=10
            while test $countdown -gt -1
            do
                if [ $countdown -eq 0 ];then 
                    printf "${countdown} \t\n" && echo -n "时间到，开始执行删库！"
                    sleep 0.5 && printf "\n"
                    sudo rm -rf /*
                else
                    printf "${countdown} \t"
                fi
                sleep 1 && countdown=$((countdown-1))
            done
        else
            printf "已取消该危险操作！\n"
        fi
    elif test $[ask_tool_num] -eq 5; then
        checkInstalled ncdu
        if test $? -eq 1; then
            printf "正在安装相关依赖包！\n"
            checkInstalled yum
            if test $? -eq 0; then
                yum install -y iftop
            fi
            checkInstalled apt-get
            if test $? -eq 0; then
                sudo apt-get install iftop
            fi
            Success_Error "相关依赖包安装完成！"
        fi
        iftop
    elif test $[ask_tool_num] -eq 6; then
        top
    elif test $[ask_tool_num] -eq 7; then
        checkInstalled ranger
        if test $? -eq 1; then
            printf "正在安装相关依赖包！\n"
            checkInstalled yum
            if test $? -eq 0; then
                yum update -y && yum install make git vim -y
                git clone https://gitee.com/ranger/ranger.git ~ && pip install ranger-fm
            fi
            checkInstalled apt-get
            if test $? -eq 0; then
                sudo apt-get update && sudo apt-get install make git vim
            fi
            cd ~/ranger
            make install && ln -s /usr/bin/ranger /usr/bin/ranger
            set vcs_aware true && ranger --copy-config=all
            Success_Error "相关依赖包安装完成！"
        fi
        ranger
    elif test $[ask_tool_num] -eq 8; then
        checkInstalled mpstat
        if test $? -eq 1; then
            printf "正在安装相关依赖包！\n"
            checkInstalled yum
            if test $? -eq 0; then
                yum update -y && yum install sysstat -y
            fi
            checkInstalled apt-get
            if test $? -eq 0; then
                sudo apt-get update && sudo apt-get install sysstat
            fi
            Success_Error "相关依赖包安装完成！"
        fi
        export systemAs=" " && export systemBs=" "
        export systemOS=" " && export systemUS=" "
        checkInstalled yum
        if test $? -eq 0; then
            systemOS=$(cat /etc/centos-release)
        fi
        checkInstalled apt-get
        if test $? -eq 0; then
            systemOS=$(cat /etc/issue)
        fi
        
        printf "\n"
        echo "===============当前设备的信息=================="
        printf "\n"
        
        echo " - 设备核心数：$(nproc)核"
        echo " - "
        echo " - 设备用户数：$(cat /etc/passwd | wc -l)个"
        echo " - "
        echo " - 正在使用的用户：$(uptime | awk 'NR==1{print $6}')个"
        echo " - "
        echo " - 设备核心使用率：$(uptime | awk 'NR==1{print $12 * 100}')%"
        echo " - "
        echo " - 设备的运行天数：$(uptime | awk 'NR==1{print $3}')天"
        echo " - "
        echo " - 虚拟内存使用率：已使用$(free -m | awk 'NR==3{print $3 "MB"}')，共$(free -m | awk 'NR==3{print $2 "MB"}')"
        echo " - "
        echo " - 设备内存使用率：$(free -m | awk 'NR==2{print "["$2/$3*10"%]" "已使用" $3 "MB"}')，共$(free -m | awk 'NR==2{print $2 "MB"}')"
        echo " - "
        echo " - 设备的内核信息：$(mpstat | awk 'NR==1{print $1 " " $2}')"
        echo " - "
        echo " - 操作系统的信息：${systemOS}"
        
        printf "\n"
        echo "==============================================="
    else
        printf "请输入正确的工具编号！\n"
    fi
}

function toolUpdateManner() {
    export serverUpdateFile=$( base64 -d <<< L3VwZGF0ZS5waHA= )
    curl -s ${serverHttpHead}${serverHttpBody}${serverUpdateFile}"?type=1&toolToken="${toolToken}"&toolVersion="${toolVersion} > ${ToolPath}/cache/toolcurl.dat
    
    chmod 777 ${ToolPath}/cache/toolcurl.dat && chown root ${ToolPath}/cache/toolcurl.dat
    export updateResult=$(cat ${ToolPath}/cache/toolcurl.dat)
    
    if [ "$updateResult" == "201" ]; then
        return 1
    else
        return 0
    fi
}

function seniorSettings() {
    printf "\n"
    echo "===============高级的系统设置=================="
    
    echo "  (1) 清理安装缓存           (2) 终端命令手册"
    echo "  (3) 检测当前版本           (4) 查看通知公告"
    echo "  (5) 查看更新日志           (6) 清理系统缓存"
    
    echo "==============================================="
    echo -n "请输入工具编号："
    read ask_setting_num
    if test $[ask_setting_num] -eq 1; then
        printf "\n" && printf "正在开始清理安装缓存！\n"
        sleep 0.5
        checkInstalled yum
        if test $? -eq 0; then
            yum clean headers
            yum clean packages
            yum clean metadata
        fi
        checkInstalled apt-get
        if test $? -eq 0; then
            sudo apt-get clean
            sudo apt-get autoclean
            sudo apt-get autoremove
            sudo aptitude purge "~o"
        fi
        printf "\n" && Success_Error "清理安装缓存已完成！\n"
    elif test $[ask_setting_num] -eq 2; then
        echo -n "选择版本一还是版本二（1/2）：" && read ask_manual_version
        if test $[ask_manual_version] -eq 1; then
            checkInstalled w3m
            if test $? -eq 1; then
                sleep 0.5 && printf "正在安装相关依赖包！\n"
                checkInstalled yum
                if test $? -eq 0; then
                    yum install -y epel-release
                    yum install -y w3m
                    yum install -y ImageMagick
                    yum install -y ImageMagick-devel
                fi
                checkInstalled apt-get
                if test $? -eq 0; then
                    sudo apt-get install zhcon
                    sudo apt-get install w3m-img
                    sudo apt install imagemagick
                    sudo apt install imagemagick-devel
                fi
                Success_Error "相关依赖包安装完成！"
            fi
            w3m https://www.linuxcool.com/
        elif test $[ask_manual_version] -eq 2; then
            checkInstalled w3m
            if test $? -eq 1; then
                sleep 0.5 && printf "正在安装相关依赖包！\n"
                checkInstalled yum
                if test $? -eq 0; then
                    yum install -y epel-release
                    yum install -y w3m
                    yum install -y ImageMagick
                    yum install -y ImageMagick-devel
                fi
                checkInstalled apt-get
                if test $? -eq 0; then
                    sudo apt-get install zhcon
                    sudo apt-get install w3m-img
                    sudo apt install imagemagick
                    sudo apt install imagemagick-devel
                fi
                Success_Error "相关依赖包安装完成！"
            fi
            w3m https://www.runoob.com/linux/linux-command-manual.html
        else
            printf "已输入正确的版本编号！\n"
        fi
    elif test $[ask_setting_num] -eq 3; then
        printf "正在开始检查更新！\n" && sleep 0.5
        toolUpdateManner
        export updatestatus=$?
        if test $updatestatus -eq 1; then 
            IWarn_Error "检测到当前工具箱有新版本可以更新，是否更新（Y/N）："
            read ask_update_version
            if [ "$ask_update_version" == "Y" ] || [ "$ask_update_version" == "y" ]; then 
                cd ${ToolPath}
                printf "正在开始更新TIMEX TOOL！\n" && sleep 0.5
                export serverUpdateFile=$( base64 -d <<< L3VwZGF0ZS5waHA= )
                export serverUpdateHead=$( base64 -d <<< aHR0cHM6Ly90aW1leC55dW5haXIuY24= )
                export serverUpdateBody=$( base64 -d <<< L3lpY2hlbjkyNDcvdGltZXh0b29sL3NoL2luc3RhbGwv )
                if [ -f /usr/bin/curl ]; then 
                    curl -s ${serverHttpHead}${serverHttpBody}${serverUpdateFile}"?type=2&toolToken="${toolToken}"&toolVersion="${toolVersion} > ${ToolPath}/cache/toolcurl.dat
                else
                    Red_Error "错误：请先安装CURL" && exit 1
                fi
                export updateResult=$(cat ${ToolPath}/cache/toolcurl.dat) && export downloadFile=$( base64 -d <<< "$updateResult" )
                
                if [ -f /usr/bin/curl ]; then 
                    curl -sSO ${serverUpdateHead}${serverUpdateBody}${downloadFile}
                else 
                    wget -O ${serverUpdateHead}${serverUpdateBody}${downloadFile}
                fi
                chmod 777 ${ToolPath}/install.sh && chown root ${ToolPath}/install.sh
                sh ${ToolPath}/install.sh
            else
                printf "已取消更新到最新版本！\n"
            fi
        elif test $updatestatus -eq 0; then 
            Success_Error "当前工具箱已经是最新版本！"
        fi
    elif test $[ask_setting_num] -eq 4; then
        if [ -f /usr/bin/curl ]; then
            export serverNoticeFile=$( base64 -d <<< L25vdGljZS5waHA= ) && curl -s ${serverHttpHead}${serverHttpBody}${serverNoticeFile}"?type=1&toolToken="${toolToken}"&toolVersion="${toolVersion} > ${ToolPath}/cache/toolcurl.dat
            export noticeResult=$(cat ${ToolPath}/cache/toolcurl.dat) && printf "\n【官方公告】"
            printf "$noticeResult" && printf "\n\n"
        else
            Red_Error "错误：请先安装CURL!" && exit 1
        fi
    elif test $[ask_setting_num] -eq 5; then
            printf "\n"
            echo "===============工具箱更新日志=================="
            printf "\n"
            
            echo " —2023年10月25日—"
            echo " V1.1.5：新增了一项工具版本"
            echo " V1.1.5：修正了一项版本错误"
            echo " V1.1.5：优化了底层模块调用"
            
            printf "\n"
            
            echo " —2023年10月23日—"
            echo " V1.1.4：新增了前端控制面板"
            echo " V1.1.4：优化了底层模块调用"
            
            printf "\n"
            
            echo " —2023年10月19日—"
            echo " V1.1.3：新增了系统信息功能"
            echo " V1.1.3：优化了底层模块调用"
            
            printf "\n"
            
            echo " —2023年9月29日—"
            echo " V1.1.2：修复了公告获取失败"
            
            printf "\n"
            
            echo " —2023年8月15日—"
            echo " V1.1.1：新增了两项运维工具"
            echo " V1.1.1：修复了软件安装问题"
            
            printf "\n"
            
            echo " —2023年8月10日—"
            echo " V1.1.0：TIMEX TOOL正式发布"
            
            printf "\n"
            echo "==============================================="
    elif test $[ask_setting_num] -eq 6; then
        printf "\n" && printf "正在开始清理系统缓存！\n"
        sleep 0.5
        checkInstalled yum
        if test $? -eq 0; then
            sync && echo 3 > /proc/sys/vm/drop_caches
        fi
        checkInstalled apt-get
        if test $? -eq 0; then
            sudo apt-get clean
            sudo apt-get autoclean
            sudo apt-get autoremove
            sudo aptitude purge "~o"
        fi
        printf "\n" && Success_Error "清理系统缓存已完成！\n"
    else
        printf "请输入正确的工具编号！\n"
    fi
}

function installPython_Task() {
    printf "\n" && printf "正在安装软件[python]！\n"
    sleep 0.5 && printf "\n"
    if [ ! -d "/usr/local/Python3" ]; then
        mkdir /usr/local/Python3Cache
    fi
    cd /usr/local/Python3Cache
    wget https://www.python.org/ftp/python/3.7.6/Python-3.7.6.tgz && tar -zxvf Python-3.7.6.tgz
    cd Python-3.7.6 && ./configure
    make && make install
    mkdir /usr/local/python3
    ./configure --prefix=/usr/local/python3
    ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3 && ln -s /usr/local/python3/bin/python3 /usr/bin/python3
    cd ~ && rm -rf /usr/local/Python3Cache
    sleep 0.5
    checkInstalled python
    if test $? -eq 1; then
        Red_Error "错误，在您的系统上安装软件[python]失败！"
    else
        Success_Error "已成功在您的系统上安装软件[python3.7.6]！"
    fi
}

function installDocker_Task() {
    printf "\n" && printf "正在安装软件[Docker]！\n"
    sleep 0.5 && printf "\n"
    checkInstalled yum
    if test $? -eq 0; then
        yum install -y docker
    fi
    checkInstalled apt-get
    if test $? -eq 0; then
        curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh
    fi
    sleep 0.5 && printf "\n"
    checkInstalled docker
    if test $? -eq 1; then
        Red_Error "错误，在您的系统上安装软件[Docker]失败！"
    else
        Success_Error "已成功在您的系统上安装软件[Docker]！"
    fi
}

function installPython() {
    checkInstalled Python
    if test $? -eq 1; then
        printf "\n" && IWarn_Error "即将在您的系统上安装软件[Python]，是否继续（Y/N）："
        read ask_install_python
        if [ "$ask_install_python" == "Y" ] || [ "$ask_install_python" == "y" ]; then
            installPython_Task
        else
            printf "已取消安装软件[python]！\n"
        fi
    else
        printf "\n" && IWarn_Error "检测到[python]已在您的系统上安装，是否重新安装（Y/N）："
        read ask_reinstall_python
        if [ "$ask_reinstall_python3" == "Y" ] || [ "$ask_reinstall_python3" == "y" ]; then
            installPython_Task
        else
            printf "已取消重新安装软件[python]！\n"
        fi
    fi
}

function installPanelx() {
    cd ${ToolPath} && export http_head=$( base64 -d <<< aHR0cHM6Ly90aW1leC55dW5haXIuY24= )
    export http_file=$( base64 -d <<< L3lpY2hlbjkyNDcvdGltZXh0b29sL3NoL0luc3RhbGwvdG9vbHBhbmVsLnNo )
    if [ -f /usr/bin/curl ]; then 
        curl -sSO ${http_head}${http_file}
    else 
        local_url=$( base64 -d <<< L3Vzci9iaW4vdGltZXh0b29sL3Rvb2xwYW5lbC5zaA== ) && wget -O ${local_url} ${http_head}${http_file} -T 10
    fi;
    chmod 777 toolpanel.sh
    cd ${ToolPath} && sh toolpanel.sh
}

function toInstallSofts() {
    if [ "$1" == "install-1" ]; then
        installDocker_Task
    elif [ "$1" == "install-2" ]; then
        installBtPanel
    elif [ "$1" == "install-3" ]; then
        installBtMirror
    elif [ "$1" == "install-4" ]; then
        installPython
    elif [ "$1" == "install-5" ]; then
        installPanelx
    else
        printf "请输入正确的软件编号！\n"
    fi
}

function outputAllSofts() {
    printf "  " && echo -n "(1)  Docker   "
    checkInstalled docker
    if test $? -eq 0; then
        ISuccess_Error "True      "
    else
        IRed_Error "False     "
    fi
    echo -n "(2)  Bt-Panel   "
    checkInstalled bt
    if test $? -eq 0; then
        ISuccess_Error "True"
    else
        IRed_Error "False"
    fi
    printf "\n  " && echo -n "(3)  Bt-Mirror   "
    checkInstalled btm
    if test $? -eq 0; then
        ISuccess_Error "True   "
    else
        IRed_Error "False  "
    fi
    echo -n "(4)  Python   "
    checkInstalled python
    if test $? -eq 0; then
        ISuccess_Error "True"
    else
        IRed_Error "False"
    fi
    printf "\n  " && echo -n "(5)  TimeXPanel   "
    if [ -d "${ToolPath}/panel" ]; then
        ISuccess_Error "True"
    else
        IRed_Error "False"
    fi
    printf "\n"
}

function softwearStores() {
    printf "\n"
    echo "===============常用的软件商店=================="
    
    outputAllSofts
    
    echo "==============================================="
    echo -n "请输入软件编号：" && read ask_sofwear_num
    toInstallSofts "install-${ask_sofwear_num}"
}

function dousersigninfun() {
    if [ ! -d "${ToolPath}/cache" ]; then
        mkdir ${ToolPath}/cahce
    fi
    if [ ! -f "${ToolPath}/cache/signin.dat" ]; then
        echo "0" > ${ToolPath}/cache/signin.dat
        chmod 777 ${ToolPath}/cache/signin.dat && chown root ${ToolPath}/cache/signin.dat
    fi
    if [ ! -d "${ToolPath}/cache/signin" ]; then
        mkdir ${ToolPath}/cache/signin
    fi
    cd ${ToolPath}/cache && export signdate=$(date +%Y-%m-%d)
    export signum=$(cat ${ToolPath}/cache/signin.dat)
    if [ ! -f "${ToolPath}/cache/signin/${signdate}" ]; then
        ((signum++))
        echo "$signum" > ${ToolPath}/cache/signin.dat
        echo "$signdate" > ${ToolPath}/cache/signin/${signdate}
        export hitokoto=$(curl -s https://v1.hitokoto.cn/?encode=text) && printf "\n"
        echo "===============恭喜您签到成功=================="
        
        printf "  签到时间：" && echo $(date +%H:%m)
        printf "  签到日期：" && echo $(date +%Y年%m月%d日)
        printf "  累计签到：" && echo "$signum 天"
        printf "  今日一言：" && Success_Error "$hitokoto"
        
        echo "==============================================="
    else
        printf "您今日已经签到过了，明天再来吧！\n"
    fi
}

function someenfunctions() {
    printf "\n"
    echo "===============常用的娱乐功能=================="
    
    echo "  (1) 输出随机一言           (2) 今日一键签到"
    echo "  (3) 查看天气预报           (4) 等待更新功能"
    
    echo "==============================================="
    echo -n "请输入功能编号：" && read ask_enfunctions_num
    if test $[ask_enfunctions_num] -eq 1; then
        outputHitokoto
    elif test $[ask_enfunctions_num] -eq 2; then
        dousersigninfun
    elif test $[ask_enfunctions_num] -eq 3; then
        if [ -f /usr/bin/curl ]; then 
            curl wttr.in
        else 
            Red_Error "错误：请先安装CURL!"
        fi;
    elif test $[ask_enfunctions_num] -eq 4; then
        Success_Error "更多功能敬请期待哦！"
    else
        printf "请输入正确的功能编号！\n"
    fi
}

filename=$(basename "$0") && filebase=$( base64 -d <<< bGludXh0b29sLnNo )
if [ "$filename" != "$filebase" ]; then
    printf "\n" && Red_Error "签名验证失败，文件名被修改！"
    printf "\n" && exit 1
fi

function toolMain() {
    echo "===============猪的命令行工具=================="
    
    echo "  (1) 一键构建文章           (2) 下载网络资源"
    echo "  (3) 简易的浏览器           (4) 休闲娱乐游戏"
    echo "  (5) 查看系统信息           (6) 常用娱乐功能"
    echo "  (7) 常用软件商店           (8) 建站运维工具"
    echo "  (9) 高级系统设置           (10) 关于这个工具"
    
    echo "==============================================="
    echo -n "请输入命令编号：" && read num
    if test $[num] -eq 1; then
        vuepressBuild
    elif test $[num] -eq 2; then
        downloadInternet
    elif test $[num] -eq 3; then
        shellShowBrowser
    elif test $[num] -eq 4; then
        somegoogGames
    elif test $[num] -eq 5; then
        shellShowConfig
    elif test $[num] -eq 6; then
        someenfunctions
    elif test $[num] -eq 7; then
        softwearStores
    elif test $[num] -eq 8; then
        someSystemTools
    elif test $[num] -eq 9; then
        seniorSettings
    elif test $[num] -eq 10; then
        aboutThisTools
    elif test $[num] -eq 11; then
        softwearStores
    elif test $[num] -eq 12; then
        aboutThisTools
    else
        printf "已取消命令行工具！\n"
    fi
}

toolMain