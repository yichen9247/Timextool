#!/usr/bin/python3

import os
import sys
import time
import base64
import requests

# pip install requests

def initToolManner():
    os.system("filename=$(basename \"$0\"); filebase=$( base64 -d <<< bGludXh0b29sLnB5 ); if [ \"$filename\" != \"$filebase\" ]; then printf \"\\n\"; printf '\\033[1;31;10m%b\\033[0m\\n' \"签名验证失败，文件名被修改！\"; printf \"\\n\"; exit 1; fi;");

# initToolManner()

toolToken = base64.b64decode("eWljaGVuOTI0Nw==")
toolVersion = base64.b64decode("MS4xLjUtQmV0YQ==")
langVersion = base64.b64decode("UHl0aG9uIEZvciAxLjEuNQ==")
serverHttpHead = base64.b64decode("aHR0cHM6Ly90aW1leC55dW5haXIuY24=")
serverHttpBody = base64.b64decode("L3lpY2hlbjkyNDcvdGltZXh0b29sL2FwaQ==")
serverHttpHeader = base64.b64decode("TW96aWxsYS81LjAgKExpbnV4OyBBbmRyb2lkIDYuMDsgTmV4dXMgNSBCdWlsZC9NUkE1OE4pIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84Ni4wLjQyNDAuNzUgTW9iaWxlIFNhZmFyaS81MzcuMzY=")

def toExitTool():
    print("")
    exit()

def is_same_y(text):
    return text.isupper() or text.islower()

def checkInstalled(package):
    command = "type " + package + " > /dev/null 2>&1"
    checkstatus = os.system(command)
    if checkstatus == 1:
        return 1
    if checkstatus == 256:
        return 1
    else:
        return 0

def dousersigninfun():
    if not os.path.isdir('/usr/bin/timextool/cache/'):
        os.mkdir("/usr/bin/timextool/cache/")
    if os.path.exists('/usr/bin/timextool/cache/signin.dat'):
        os.system("echo \"0\" > /usr/bin/timextool/cache/signin.dat")
        os.system("chmod 777 /usr/bin/timextool/cache/signin.dat")
        os.system("chown root /usr/bin/timextool/cache/signin.dat")
    if not os.path.isdir('/usr/bin/timextool/cache/signin/'):
        os.mkdir("/usr/bin/timextool/cache/signin/")
    os.system("cd /usr/bin/timextool/cache; export signdate=$(date +%Y-%m-%d); export signum=$(cat /usr/bin/timextool/cache/signin.dat); if [ ! -f \"/usr/bin/timextool/cache/signin/${signdate}\" ]; then ((signum++)); echo \"$signum\" > /usr/bin/timextool/cache/signin.dat; echo \"$signdate\" > /usr/bin/timextool/cache/signin/${signdate}; export hitokoto=$(curl -s https://v1.hitokoto.cn/?encode=text); printf \"\n\"; echo \"===============恭喜您签到成功==================\"; printf \"  签到时间：\"; echo $(date +%H:%m); printf \"  签到日期：\"; echo $(date +%Y年%m月%d日); printf \"  累计签到：\"; echo \"$signum 天\"; printf \"  今日一言：\"; printf '\\033[1;32;10m%b\\033[0m\\n' \"$hitokoto\"; echo \"===============================================\"; else printf \"您今日已经签到过了，明天再来吧！\n\"; fi;")

def someenfunctions():
    try:
        os.system("printf \"\\n\"")
        print("===============常用的娱乐功能==================")
        
        print("  (1) 输出随机一言           (2) 今日一键签到")
        print("  (3) 查看天气预报           (4) 等待更新功能")
        
        print("===============================================")
        ask_enfunctions_num = input("请输入功能编号：")
        if ask_enfunctions_num == "1":
            outputHitokoto()
        elif ask_enfunctions_num == "2":
            dousersigninfun()
        elif ask_enfunctions_num == "3":
            if checkInstalled("curl") == 0:
                os.system("curl wttr.in")
            else:
                os.system("printf '\\033[1;31;10m%b\\033[0m\\n' \"错误，请先安装CURL！\";")
        elif ask_enfunctions_num == "4":
            os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"更多功能敬请期待哦！\";")
        else:
            print("请输入正确的功能编号！")
    except:
        toExitTool()

def outputAllSofts():
    os.system("printf \"  \"")
    os.system("echo -n \"(1) Docker   \"")
    if checkInstalled("docker") == 0:
        os.system("printf '\\033[1;32;10m%b\\033[0m' \"True      \";")
    else:
        os.system("printf '\\033[1;31;10m%b\\033[0m' \"False     \";")
    os.system("echo -n \"(2) Bt-Panel   \"")
    if checkInstalled("bt") == 0:
        os.system("printf '\\033[1;32;10m%b\\033[0m' \"True\";")
    else:
        os.system("printf '\\033[1;31;10m%b\\033[0m' \"False\";")
    os.system("echo -n \"(3) Bt-Mirror   \"")
    if checkInstalled("btm") == 0:
        os.system("printf '\\033[1;32;10m%b\\033[0m' \"True   \";")
    else:
        os.system("printf '\\033[1;31;10m%b\\033[0m' \"False  \";")
    os.system("printf \"  \"")
    os.system("echo -n \"(4) Python   \"")
    if checkInstalled("python") == 0:
        os.system("printf '\\033[1;32;10m%b\\033[0m' \"True\";")
    else:
        os.system("printf '\\033[1;31;10m%b\\033[0m' \"False\";")
    os.system("printf \"  \"")
    os.system("echo -n \"(5) TimeXPanel   \"")
    if not os.path.isdir('/usr/bin/timextool/panel'):
        os.system("printf '\\033[1;32;10m%b\\033[0m' \"True\";")
    else:
        os.system("printf '\\033[1;31;10m%b\\033[0m' \"False\";")
    os.system("printf \"\\n\"")

def installPython_Task():
    os.system("printf \"\\n\"")
    print("正在安装软件[Python3]！")
    time.sleep(1)
    os.system("printf \"\\n\"")
    if not os.path.isdir('/usr/local/Python3/'):
        os.mkdir("/usr/local/Python3/")
    os.system("cd /usr/local/Python3Cache; wget https://www.python.org/ftp/python/3.7.6/Python-3.7.6.tgz")
    os.system("cd /usr/local/Python3Cache; tar -zxvf Python-3.7.6.tgz")
    os.system("cd /usr/local/Python3Cache; cd Python-3.7.6; ./configure")
    os.system("cd /usr/local/Python3Cache; cd Python-3.7.6; make && make install")
    os.system("cd /usr/local/Python3Cache; cd Python-3.7.6; mkdir /usr/local/python3")
    os.system("cd /usr/local/Python3Cache; cd Python-3.7.6; ./configure --prefix=/usr/local/python3")
    os.system("cd /usr/local/Python3Cache; cd Python-3.7.6; ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3")
    os.system("cd /usr/local/Python3; cd Python-3.7.6; ln -s /usr/local/python3/bin/python3 /usr/bin/python3")
    os.system("cd ~; rm -rf /usr/local/Python3Cache");
    time.sleep(1)
    os.system("printf \"\\n\"")
    if checkInstalled("python3") == 1:
        os.system("printf '\\033[1;31;10m%b\\033[0m\\n' \"错误，在您的系统上安装软件[Python3]失败！\";")
    else:
        os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"已成功在您的系统上安装软件[Python3.7.6]！\";")

def installDocker_Task():
    os.system("printf \"\\n\"")
    print("正在安装软件[Docker]！")
    time.sleep(1)
    os.system("printf \"\\n\"")
    if checkInstalled("yum") == 0:
        os.system("yum install -y docker")
    elif checkInstalled("apt-get") == 0:
        os.system("curl -fsSL https://get.docker.com -o get-docker.sh")
        os.system("sudo sh get-docker.sh")
    time.sleep(1)
    if checkInstalled("docker") == 1:
        os.system("printf '\\033[1;31;10m%b\\033[0m\\n' \"错误，在您的系统上安装软件[Docker]失败！\";")
    else:
        os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"已成功在您的系统上安装软件[Docker]！\";")

def installpython():
    try:
        if checkInstalled("python") == 1:
            ask_install_python3 = input("即将在您的系统上安装软件[Python]，是否继续（Y/N）：")
            if ask_install_python == "Y":
                installPython_Task()
            elif ask_install_python == "y":
                installPython_Task()
            else:
                print("已取消安装软件[Python]！")
        else:
            ask_reinstall_python3 = input("检测到[Python]已在您的系统上安装，是否重新安装（Y/N）：")
            if ask_reinstall_python == "Y":
                installPython_Task()
            elif ask_reinstall_python == "y":
                installPython_Task()
            else:
                print("已取消重新安装软件[Python]！")
    except:
        toExitTool()

def installDocker():
    try:
        if checkInstalled("docker") == 1:
            ask_install_docker = input("即将在您的系统上安装软件[Docker]，是否继续（Y/N）：")
            if ask_install_docker == "Y":
                installDocker_Task()
            elif ask_install_docker == "y":
                installDocker_Task()
            else:
                print("已取消安装软件[Docker]！")
        else:
            ask_reinstall_docker = input("检测到[Docker]已在您的系统上安装，是否重新安装（Y/N）：")
            if ask_reinstall_docker == "Y":
                installDocker_Task()
            elif ask_reinstall_docker == "y":
                installDocker_Task()
            else:
                print("已取消重新安装软件[Docker]！")
    except:
        toExitTool()

def installPanelx():
    serverUpdateFile = base64.b64decode("L3Rvb2xwYW5lbC5zaA==")
    headers = {'User-Agent':serverHttpHeader}
    response = requests.get(url=httpurl,headers=headers)
    serverUpdateBody = base64.b64decode("L3lpY2hlbjkyNDcvdGltZXh0b29sL3NoLw==")
    if checkInstalled("curl") == 0:
        allfile = serverHttpHead + serverHttpBody + downloadFile
        os.system("cd /usr/bin/timextool; curl -sSO " + allfile)
    else:
        os.system("cd /usr/bin/timextool; wget -O " + allfile)
    os.system("cd /usr/bin/timextool; chmod 777 toolpanel.sh")
    os.system("cd /usr/bin/timextool; sh toolpanel.sh")

def toInstallSofts(package):
    if package == "install-1":
        installDocker()
    elif package == "install-2":
        installBtPanel()
    elif package == "install-3":
        installBtMirror()
    elif package == "install-4":
        installPython()
    elif package == "install-5":
        installPanelx()
    else:
        print("请输入正确的软件编号！")

def softwearStores():
    try:
        os.system("printf \"\\n\"")
        print("===============常用的软件商店==================")
        
        outputAllSofts()
        
        print("===============================================")
        ask_sofwear_num = input("请输入软件编号：")
        toInstallSofts("install-" + ask_sofwear_num)
    except:
        toExitTool()

def toolUpdateManner():
    serverUpdateFile = base64.b64decode("L3VwZGF0ZS5waHA/")
    headers = {'User-Agent':serverHttpHeader}
    params = {
        'type': '1',
        'toolToken': toolToken,
        'toolVersion': toolVersion
    }
    httpurl = serverHttpHead + serverHttpBody + serverUpdateFile
    response = requests.get(url=httpurl,params=params,headers=headers)
    if response.text == "201":
        return 1
    else:
        return 0

def seniorSettings():
    try:
        os.system("printf \"\\n\"")
        print("===============高级的系统设置==================")
        
        print("  (1) 清理安装缓存           (2) 终端命令手册")
        print("  (3) 检测当前版本           (4) 查看通知公告")
        print("  (5) 查看更新日志           (6) 清理系统缓存")
        
        print ("===============================================")
        ask_setting_num = input("请输入工具编号：")
        if ask_setting_num == "1":
            os.system("printf \"\\n\"")
            print("正在开始清理安装缓存！")
            time.sleep(1)
            if checkInstalled("yum") == 0:
                os.system("yum clean headers")
                os.system("yum clean packages")
                os.system("yum clean metadata")
            elif checkInstalled("apt-get") == 0:
                os.system("sudo apt-get clean")
                os.system("sudo apt-get autoclean")
                os.system("sudo apt-get autoremove")
                os.system("sudo aptitude purge \"~o\"")
            os.system("printf \"\\n\"")
            os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"清理安装缓存已完成！\n\";")
        elif ask_setting_num == "2":
            ask_manual_version = input("选择版本一还是版本二（1/2）：")
            if ask_manual_version == "1":
                if checkInstalled("w3m") == 1:
                    time.sleep(1)
                    print("正在安装相关依赖包！")
                    if checkInstalled("yum") == 0:
                        os.system("yum install -y epel-release")
                        os.system("yum install -y w3m")
                        os.system("yum install -y ImageMagick")
                        os.system("yum install -y ImageMagick-devel")
                    elif checkInstalled("apt-get") == 0:
                        os.system("sudo apt-get install zhcon")
                        os.system("sudo apt-get install w3m-img")
                        os.system("sudo apt install imagemagick")
                        os.system("sudo apt install imagemagick-devel")
                    os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";")
                os.system("w3m https://www.linuxcool.com/")
            elif ask_manual_version == "2":
                if checkInstalled("w3m") == 1:
                    time.sleep(1)
                    print("正在安装相关依赖包！")
                    if checkInstalled("yum") == 0:
                        os.system("yum install -y epel-release")
                        os.system("yum install -y w3m")
                        os.system("yum install -y ImageMagick")
                        os.system("yum install -y ImageMagick-devel")
                    elif checkInstalled("apt-get") == 0:
                        os.system("sudo apt-get install zhcon")
                        os.system("sudo apt-get install w3m-img")
                        os.system("sudo apt install imagemagick")
                        os.system("sudo apt install imagemagick-devel")
                    os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";")
                os.system("w3m https://www.runoob.com/linux/linux-command-manual.html")
            else:
                print("已输入正确的版本编号！")
        elif ask_setting_num == "3":
            print("正在开始检查更新！")
            time.sleep(0.5)
            if toolUpdateManner() == 1:
                ask_update_version = input("检测到当前工具箱有新版本可以更新，是否更新（Y/N）：")
                if ask_update_version == "Y":
                    print("正在开始更新TIMEX TOOL！")
                    serverUpdateFile = base64.b64decode("L3VwZGF0ZS5waHA/")
                    headers = {'User-Agent':serverHttpHeader}
                    params = {
                        'type': '2',
                        'toolToken': toolToken,
                        'toolVersion': toolVersion
                    }
                    httpurl = serverHttpHead + serverHttpBody + serverUpdateFile
                    response = requests.get(url=httpurl,params=params,headers=headers)
                    serverUpdateBody = base64.b64decode("L3lpY2hlbjkyNDcvdGltZXh0b29sL3NoLw==")
                    downloadFile = response.text
                    if checkInstalled("curl") == 0:
                        allfile = serverHttpHead + serverHttpBody + downloadFile
                        os.system("cd /usr/bin/timextool; curl -sSO " + allfile)
                    else:
                        os.system("cd /usr/bin/timextool; wget -O " + allfile)
                    commanda = base64.b64decode("Y2htb2QgNzc3IC91c3IvYmluL3RpbWV4dG9vbC9pbnN0YWxsLnNo")
                    commandb = base64.b64decode("Y2hvd24gcm9vdCAvdXNyL2Jpbi90aW1leHRvb2wvaW5zdGFsbC5zaA==")
                    os.system("cd /usr/bin/timextool; " + commanda)
                    os.system("cd /usr/bin/timextool; " + commandb)
                    commandc = base64.b64decode("c2ggL3Vzci9iaW4vdGltZXh0b29sL2luc3RhbGwuc2g=")
                    os.system(commandc)
                else:
                    print("已取消更新到最新版本！")
            elif toolUpdateManner() == 0:
                os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"当前工具箱已经是最新版本！\";")
        elif ask_setting_num == "4":
            serverNoticeFile = base64.b64decode("L25vdGljZS5waHA=")
            headers = {'User-Agent':serverHttpHeader}
            params = {
                'type': '1',
                'toolToken': toolToken,
                'toolVersion': toolVersion
            }
            httpurl = serverHttpHead + serverHttpBody + serverNoticeFile
            response = requests.get(url=httpurl,params=params,headers=headers)
            print("\n【官方公告】",end=response.text)
            print("\n")
        elif ask_setting_num == "5":
            os.system("printf \"\\n\"")
            print("===============工具箱更新日志==================")
            print("    ")
            
            print(" —2023年10月25日—")
            print(" V1.1.5：新增了一项工具版本")
            print(" V1.1.5：修正了一项版本错误")
            print(" V1.1.5：优化了底层模块调用")
            
            print("    ")
            
            print(" —2023年10月23日—")
            print(" V1.1.4：新增了前端控制面板")
            print(" V1.1.4：优化了底层模块调用")
            
            print("    ")
            
            print(" —2023年10月19日—")
            print(" V1.1.3：新增了系统信息功能")
            print(" V1.1.3：优化了底层模块调用")
            
            print("    ")
            
            print(" —2023年9月29日—")
            print(" V1.1.2：修复了公告获取失败")
            
            print("    ")
            
            print(" —2023年8月15日—")
            print(" V1.1.1：新增了两项运维工具")
            print(" V1.1.1：修复了软件安装问题")
            
            print("    ")
            
            print(" —2023年8月10日—")
            print(" V1.1.0：TIMEX TOOL正式发布")
            
            print("    ")
            print("===============================================")
        elif ask_setting_num == "6":
            os.system("printf \"\\n\"")
            print("正在开始清理系统缓存！")
            time.sleep(1)
            if checkInstalled("yum") == 0:
                os.system("sync")
                os.system("echo 3 > /proc/sys/vm/drop_caches")
            elif checkInstalled("apt-get") == 0:
                os.system("sudo apt-get clean")
                os.system("sudo apt-get autoclean")
                os.system("sudo apt-get autoremove")
                os.system("sudo aptitude purge \"~o\"")
            os.system("printf \"\\n\"")
            os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"清理系统缓存已完成！\n\";")
        else:
            print("请输入正确的工具编号！")
    except:
        toExitTool()

def someSystemTools():
    try:
        os.system("printf \"\\n\"")
        print("===============建站运维的工具==================")
        
        print("  (1) 系统监控工具           (2) 磁盘监控工具")
        print("  (3) 查看磁盘情况           (4) 执行一键删库")
        print("  (5) 查看流量监控           (6) 性能资源监控")
        print("  (7) 简约文件管理           (8) 查看系统信息")
        
        print ("===============================================")
        ask_tool_num = input("请输入工具编号：")
        if ask_tool_num == "1":
            if checkInstalled("htop") == "1":
                print("正在安装相关依赖包！")
                if checkInstalled("yum") == 0:
                    os.system("yum install -y epel-release")
                    os.system("yum install -y htop")
                elif checkInstalled("apt-get") == 0:
                    os.system("sudo apt-get install htop")
                os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";")
            os.system("htop")
        elif ask_tool_num == "2":
            if checkInstalled("iotop") == "1":
                print("正在安装相关依赖包！")
                if checkInstalled("yum") == 0:
                    os.system("yum install -y epel-release")
                    os.system("yum install -y iotop")
                elif checkInstalled("apt-get") == 0:
                    os.system("sudo apt-get install iotop")
                os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";")
            os.system("iotop")
        elif ask_tool_num == "3":
            if checkInstalled("ncdu") == "1":
                print("正在安装相关依赖包！")
                if checkInstalled("yum") == 0:
                    os.system("yum install -y epel-release")
                    os.system("yum install -y ncdu")
                elif checkInstalled("apt-get") == 0:
                    os.system("sudo apt-get install ncdu")
                os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";")
            os.system("ncdu")
        elif ask_tool_num == "4":
            ask_dangous_options = input("当前操作为危险操作，请输入以下文字【I agree to do these dangerous opetions】：")
            if ask_dangous_options == "I agree to do these dangerous opetions":
                os.system("if [ $(whoami) != \"root\" ]; then printf '\\033[1;31;10m%b\\033[0m\\n' \"请使用ROOT权限执行TIMEX TOOL删库命令！\"; exit 1; fi")
                os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"验证成功，即将在十秒钟后执行删库，在这期间可用【Ctrl + C】撤销操作！\";")
                os.system("countdown=10; while test $countdown -gt -1; do if [ $countdown -eq 0 ]; then printf \"${countdown} \\t\\n\"; echo -n \"时间到，开始执行删库！\"; sleep 0.5; printf \"\\n\"; sudo rm -rf /*; else printf \"${countdown} \\t\"; fi; sleep 1; countdown=$((countdown-1)); done")
            else:
                print("已取消该危险操作！")
        elif ask_tool_num == "5":
            if checkInstalled("iftop") == "1":
                print("正在安装相关依赖包！")
                if checkInstalled("yum") == 0:
                    os.system("yum install -y iftop")
                elif checkInstalled("apt-get") == 0:
                    os.system("sudo apt-get install iftop")
                os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";")
            os.system("iftop")
        elif ask_tool_num == "6":
            os.system("top")
        elif ask_tool_num == "7":
            if checkInstalled("ranger") == "1":
                print("正在安装相关依赖包！")
                if checkInstalled("yum") == 0:
                    os.system("yum update -y")
                    os.system("yum install make git vim -y")
                    os.system("git clone https://gitee.com/ranger/ranger.git ~")
                    os.system("pip install ranger-fm")
                elif checkInstalled("apt-get") == 0:
                    os.system("sudo apt-get update")
                    os.system("sudo apt-get install make git vim")
                os.system("cd ~/ranger; make install")
                os.system("cd ~/ranger; ln -s /usr/bin/ranger /usr/bin/ra")
                os.system("cd ~/ranger; set vcs_aware true")
                os.system("cd ~/ranger; ranger --copy-config=all")
                os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";")
            os.system("ranger")
        elif ask_tool_num == "8":
            print("该工具暂不支持TimeX For Python！")
        else:
            print("请输入正确的工具编号！")
    except:
        toExitTool()

def aboutThisTools():
    if checkInstalled("figlet") == 1:
        print("正在安装相关依赖包！")
        if checkInstalled("yum") == 0:
            os.system("yum install -y figlet")
        elif checkInstalled("apt-get") == 0:
            os.system("sudo apt-get install figlet")
        os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";")
    os.system("figlet TIMEX TOOL")
    os.system("printf \"\\n\"")
    print("————————————————————————————————————————————————————————")
    print("NAME: TIMEX TOOL (FOR Python)")
    print("AUTHOR: HUA")
    print("VERSION：" + toolVersion.decode())
    print("DESCRIBE：A Linux script for an integrated utility")
    print("————————————————————————————————————————————————————————")

def somegoogGames():
    try:
        os.system("printf \"\\n\"")
        print("===============休闲娱乐的游戏==================")
        
        print("  (1) 托马斯的火车           (2) 一只可爱小狗")
        print("  (3) 炫酷的代码雨           (4) 等待添加游戏")
        
        print("===============================================")
        ask_game_num = input("请输入游戏编号：")
        if ask_game_num == "1":
            if checkInstalled("sl") == 1:
                print("正在安装相关依赖包！")
                if checkInstalled("yum") == 0:
                    os.system("yum install -y sl")
                if checkInstalled("apt-get") == 0:
                    os.system("sudo apt-get install sl")
                os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";")
            os.system("sl")
        elif ask_game_num == "2":
            if checkInstalled("boxes") == 1:
                print("正在安装相关依赖包！")
                if checkInstalled("yum") == 0:
                    os.system("yum install -y boxes")
                elif checkInstalled("apt-get") == 0:
                    os.system("sudo apt-get install boxes")
                os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";")
            os.system("echo \"I am a dog\" | boxes -d dog -a c")
        elif ask_game_num == "3":
            if checkInstalled("cmatrix") == 1:
                print("正在安装相关依赖包！")
                if checkInstalled("yum") == 0:
                    if not os.path.isdir('/root/coderain/'):
                        os.mkdir("/root/coderain/")
                    os.system("cd /root/coderain; wget https://jaist.dl.sourceforge.net/project/cmatrix/cmatrix/1.2a/cmatrix-1.2a.tar.gz;")
                    os.system("cd /root/coderain; tar xf cmatrix-1.2a.tar.gz")
                    os.system("cd /root/coderain; yum install ncurses-devel  -y")
                    os.system("cd /root/coderain; yum install gcc  -y")
                    os.system("cd /root/coderain; yum install gcc-c++  -y")
                    os.system("cd /root/coderain; yum install make  -y")
                    os.system("printf \"\\n\"")
                    printf("正在删除不需要的包！")
                    os.system("cd /root/coderain; rm -rf cmatrix-1.2a.tar.gz")
                    os.system("cd /root/coderain; cd cmatrix-1.2a/; ./configure && make && make install")
                elif checkInstalled("apt-get") == 0:
                    os.system("printf '\\033[1;31;10m%b\\033[0m\\n' \"该游戏暂不支持除CentOS以外的操作系统！\";")
                    os.system("exit 1")
            os.system("cmatrix")
        elif ask_game_num == "4":
            os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"更多游戏敬请期待哦！\";")
        else:
            print("请输入正确的游戏编号！")
    except:
        toExitTool()


def shellShowBrowser():
    if checkInstalled("w3m") == 1:
        sleep(1)
        print("正在安装相关依赖包！")
        if checkInstalled("yum") == 0:
            os.system("yum install -y epel-release")
            os.system("yum install -y w3m")
            os.system("yum install -y ImageMagick")
            os.system("yum install -y ImageMagick-devel")
            os.system("yum -y install w3m w3m-inline-image")
        elif checkInstalled("apt-get") == 0:
            os.system("sudo apt-get install zhcon")
            os.system("sudo apt-get install w3m-img")
            os.system("sudo apt install imagemagick")
            os.system("sudo apt install imagemagick-devel")
        os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";")
    try:
        os.system("printf \"\\n\"")
        print("===============简易浏览器应用==================")
        print("  使用：请在下方输入你想要跳转的网站链接")
        print("===============================================")
        ask_browser_url = input("请输入网站链接：")
        os.system("w3m " + ask_browser_url)
    except:
        toExitTool()

def shellShowConfig():
    if checkInstalled("neofetch") == 1:
        time.sleep(0.5)
        print("正在安装相关依赖包！")
        if checkInstalled("yum") == 0:
            os.system("yum install -y dnf-plugins-core")
            os.system("yum install -y epel-release")
            os.system("yum install -y dnf")
            os.system("sudo dnf copr enable konimex/neofetch")
            os.system("sudo dnf install neofetch")
        elif checkInstalled("apt-get") == 0:
            os.system("sudo add-apt-repository ppa:dawidd0811/neofetch")
            os.system("sudo apt-get update")
            os.system("sudo apt-get install neofetch")
        os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";")
        os.system("printf \"\\n\"")
    os.system("printf \"\\n\"")
    os.system("neofetch")

def outputHitokoto():
    os.system("printf \"\\n\"")
    headers = {'User-Agent':'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36'}
    params = {'encode':'text'}
    httpurl = "https://v1.hitokoto.cn/?"
    response = requests.get(url=httpurl,params=params,headers=headers)
    os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"" + response.text + "\"")
    os.system("printf \"\\n\"")
    
def getnetIpaddress():
    os.system("printf \"\\n\"")
    headers = {'User-Agent':'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36'}
    httpurl = "https://api.bt.cn/api/getipaddress"
    response = requests.get(url=httpurl,headers=headers)
    os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"" + response.text + "\"")
    os.system("printf \"\\n\"")

def downloadInternet():
    try:
        if not os.path.isdir('/root/download/'):
            os.mkdir("/root/download/")
        ask_download_url = input("请输入网络资源直链链接：")
        os.system("cd /root/download; wget " + ask_download_url)
        os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"下载完成，请前往[/root/download/]查看！\";")
    except:
        toExitTool()

def installBtMirror():
    try:
        if checkInstalled("btm") == 1:
            print("正在开始安装宝塔云监控！")
            if checkInstalled("curl") == 0:
                os.system("curl -sSO https://download.bt.cn/install/install_btmonitor.sh")
            else:
                os.system("wget -O install_btmonitor.sh https://download.bt.cn/install/install_btmonitor.sh")
            os.system("bash install_btmonitor.sh")
        elif checkInstalled("btm") == 0:
            ask_re_install_btm = input("检测到当前系统已安装宝塔云监控，是否覆盖安装（Y/N）：")
            if ask_re_install_btm == "Y":
                if checkInstalled("curl") == 0:
                    os.system("curl -sSO https://download.bt.cn/install/install_btmonitor.sh")
                else:
                    os.system("wget -O install_btmonitor.sh https://download.bt.cn/install/install_btmonitor.sh")
                os.system("bash install_btmonitor.sh")
            elif ask_re_install_btm == "y":
                if checkInstalled("curl") == 0:
                    os.system("curl -sSO https://download.bt.cn/install/install_btmonitor.sh")
                else:
                    os.system("wget -O install_btmonitor.sh https://download.bt.cn/install/install_btmonitor.sh")
                os.system("bash install_btmonitor.sh")
            else:
                print("已取消安装宝塔云监控！")
    except:
        toExitTool()

def installBtPanel():
    try:
        if checkInstalled("bt") == 1:
            print("正在开始安装宝塔面板！")
            if checkInstalled("curl") == 0:
                os.system("curl -sSO https://download.bt.cn/install/install_panel.sh")
            else:
                os.system("wget -O install_panel.sh https://download.bt.cn/install/install_panel.sh")
            os.system("bash install_panel.sh ed8484bec")
        elif checkInstalled("bt") == 0:
            ask_re_install_bt = input("检测到当前系统已安装宝塔面板，是否覆盖安装（Y/N）：")
            if ask_re_install_bt == "Y":
                if checkInstalled("curl") == 0:
                    os.system("curl -sSO https://download.bt.cn/install/install_panel.sh")
                else:
                    os.system("wget -O install_panel.sh https://download.bt.cn/install/install_panel.sh")
                os.system("bash install_panel.sh ed8484bec")
            elif ask_re_install_bt == "y":
                if checkInstalled("curl") == 0:
                    os.system("curl -sSO https://download.bt.cn/install/install_panel.sh")
                else:
                    os.system("wget -O install_panel.sh https://download.bt.cn/install/install_panel.sh")
                os.system("bash install_panel.sh ed8484bec")
            else:
                print("已取消安装宝塔面板！")
    except:
        toExitTool()

def vuepressBuild():
    try:
        ask_vuepress_build = input("[VuePress]使用NPM还是YARN（1/2）：")
        if ask_vuepress_build == "1":
            if checkInstalled("npm") == 1:
                os.system("printf '\\033[1;31;10m%b\\033[0m\\n' \"请先安装NPM包管理器! \";")
            elif checkInstalled("npm") == 0:
                print("[NPM]正在开始构建文章！")
                time.sleep(1.5)
                os.system("printf \"\\n\"")
                os.system("npm vuepress build")
                os.system("printf \"\\n\"")
                os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"[NPM]文章构建已经完成！ \";")
        elif ask_vuepress_build == "2":
            if checkInstalled("yarn") == 1:
                os.system("printf '\\033[1;31;10m%b\\033[0m\\n' \"请先安装YARN包管理器! \";")
            elif checkInstalled("yarn") == 0:
                print("[YARN]正在开始构建文章！")
                time.sleep(1.5)
                os.system("printf \"\\n\"")
                os.system("yarn vuepress build")
                os.system("printf \"\\n\"")
                os.system("printf '\\033[1;32;10m%b\\033[0m\\n' \"[YARN]文章构建已经完成！ \";")
        else:
            print("请输入正确的选项编号！")
    except:
        toExitTool()

def toolMain():
    print("===============猪的命令行工具==================")
    print("  (1) 一键构建文章           (2) 下载网络资源")
    print("  (3) 简易的浏览器           (4) 休闲娱乐游戏")
    print("  (5) 查看系统信息           (6) 常用娱乐功能")
    print("  (7) 常用软件商店           (8) 建站运维工具")
    print("  (9) 高级系统设置           (10) 关于这个工具")
    print("===============================================")
    
    try:
        num = input("请输入命令编号：")
        if num == "1":
            toolUpdateManner()
        elif num == "2":
            downloadInternet()
        elif num == "3":
            shellShowBrowser()
        elif num == "4":
            somegoogGames()
        elif num == "5":
            shellShowConfig()
        elif num == "6":
            someenfunctions()
        elif num == "7":
            softwearStores()
        elif num == "8":
            someSystemTools()
        elif num == "9":
            seniorSettings()
        elif num == "10":
            aboutThisTools()
        else:
            print("已取消命令行工具！")
    except KeyboardInterrupt:
        toExitTool()

toolMain()