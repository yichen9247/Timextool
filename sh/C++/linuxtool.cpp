#include <string>
#include <thread>
#include <cstdlib>
#include <iostream>

using namespace std;

int checkInstalled(const char *package) {
    string command = "type  " + string(package) + " > /dev/null 2>&1";
    int result = system(command.c_str());
    if (result == 0) {
        return 0;
    } else {
        return 1;
    }
}

int outputHitokoto(void) {
    cout << "" << "\n";
    if (checkInstalled("curl") == 0) {
        system("export hitokoto=$(curl -s https://v1.hitokoto.cn/?encode=text); printf '\\033[1;32;10m%b\\033[0m\\n' \"$hitokoto\";");
    } else {
        system("printf '\\033[1;31;10m%b\\033[0m\\n' \"错误，请先安装CURL！\";");
    }
    cout << "" << "\n";
}

int getnetIpaddress(void) {
    cout << "" << "\n";
    if (checkInstalled("curl") == 0) {
        system("export ipaddress=$(curl -s https://api.bt.cn/api/getipaddress); printf '\\033[1;32;10m%b\\033[0m\\n' \"$ipaddress\";");
    } else {
        system("printf '\\033[1;31;10m%b\\033[0m\\n' \"错误，请先安装CURL！\";");
    }
    cout << "" << "\n";
}

int dousersigninfun(void) {
    system("if [ ! -d '/usr/bin/timextool/cache/' ];then mkdir /usr/bin/timextool/cache/; fi");
    system("if [ ! -f '/usr/bin/timextool/cache/signin.dat' ];then echo '0' > /usr/bin/timextool/cache/signin.dat;chmod 777 /usr/bin/timextool/cache/signin.dat; chown root /usr/bin/timextool/cache/signin.dat; fi");
    system("if [ ! -d '/usr/bin/timextool/cache/signin/' ];then mkdir /usr/bin/timextool/cache/signin/; fi");
    system("cd /usr/bin/timextool/cache; export signdate=$(date +%Y-%m-%d); export signum=$(cat /usr/bin/timextool/cache/signin.dat); if [ ! -f \"/usr/bin/timextool/cache/signin/${signdate}\" ]; then ((signum++)); echo \"$signum\" > /usr/bin/timextool/cache/signin.dat; echo \"$signdate\" > /usr/bin/timextool/cache/signin/${signdate}; export hitokoto=$(curl -s https://v1.hitokoto.cn/?encode=text); printf \"\n\"; echo \"===============恭喜您签到成功==================\"; printf \"  签到时间：\"; echo $(date +%H:%m); printf \"  签到日期：\"; echo $(date +%Y年%m月%d日); printf \"  累计签到：\"; echo \"$signum 天\"; printf \"  今日一言：\"; printf '\\033[1;32;10m%b\\033[0m\\n' \"$hitokoto\"; echo \"===============================================\"; else printf \"您今日已经签到过了，明天再来吧！\n\"; fi;");
}


int installBtMirror(void) {
    if (checkInstalled("btm") == 1) {
        cout << "正在开始安装宝塔云监控！" << endl;
        if (checkInstalled("curl") == 0) {
            system("curl -sSO https://download.bt.cn/install/install_btmonitor.sh");
        } else {
            system("wget -O install_btmonitor.sh https://download.bt.cn/install/install_btmonitor.sh");
        }
        system("bash install_panel.sh ed8484bec");
    } else 
    if (checkInstalled("bt") == 0) {
        cout << "" << endl;
        string ask_re_install_btm;
        system("printf '\\033[1;33;10m%b\\033[0m' \"检测到当前系统已安装宝塔云监控，是否覆盖安装（Y/N）： \";");
        cin >> ask_re_install_btm;
        if (ask_re_install_btm.compare("Y") == 0  || ask_re_install_btm.compare("y") == 0) {
            if (checkInstalled("curl") == 0) {
                system("curl -sSO https://download.bt.cn/install/install_btmonitor.sh");
            } else {
                system("wget -O install_btmonitor.sh https://download.bt.cn/install/install_btmonitor.sh");
            }
            system("bash install_panel.sh ed8484bec");
        } else {
            cout << "已取消安装宝塔云监控！" << endl;
        }
    }
}

int installBtPanel(void) {
    if (checkInstalled("bt") == 1) {
        cout << "正在开始安装宝塔面板！" << endl;
        if (checkInstalled("curl") == 0) {
            system("curl -sSO https://download.bt.cn/install/install_panel.sh");
        } else {
            system("wget -O install_panel.sh https://download.bt.cn/install/install_panel.sh");
        }
        system("bash install_panel.sh ed8484bec");
    } else 
    if (checkInstalled("bt") == 0) {
        cout << "" << endl;
        string ask_re_install_bt;
        system("printf '\\033[1;33;10m%b\\033[0m' \"检测到当前系统已安装宝塔面板，是否覆盖安装（Y/N）： \";");
        cin >> ask_re_install_bt;
        if (ask_re_install_bt.compare("Y") == 0  || ask_re_install_bt.compare("y") == 0) {
            if (checkInstalled("curl") == 0) {
                system("curl -sSO https://download.bt.cn/install/install_panel.sh");
            } else {
                system("wget -O install_panel.sh https://download.bt.cn/install/install_panel.sh");
            }
            system("bash install_panel.sh ed8484bec");
        } else {
            cout << "已取消安装宝塔面板！" << endl;
        }
    }
}

int someenfunctions(void) {
    cout << "" << "\n";
    int ask_enfunctions_num;
    cout << "===============常用的娱乐功能==================" << "\n";
    
    cout << "  (1) 输出随机一言           (2) 今日一键签到" << "\n";
    cout << "  (3) 查看天气预报           (4) 等待更新功能" << "\n";
    
    cout << "===============================================" << "\n";
    cout << "请输入功能编号：" << "";
    cin >> ask_enfunctions_num;
    if (cin.fail()) {
        cout << "请输入正确的功能编号！" << endl;
        return 1;
    }
    
    switch(ask_enfunctions_num) {
        case 1:
            outputHitokoto();
            break;
        case 2:
            dousersigninfun();
            break;
        case 3:
            if (checkInstalled("curl") == 0) {
                system("curl wttr.in");
            } else {
                system("printf '\\033[1;31;10m%b\\033[0m\\n' \"错误，请先安装CURL！\";");
            }
            break;
        case 4:
            system("printf '\\033[1;32;10m%b\\033[0m\\n' \"更多功能敬请期待哦！\";");
            break;
        default:
            cout << "请输入正确的功能编号！" << endl;
            break;
    }
}

int installPython_Task(void) {
    cout << "" << "\n";
    cout << "正在安装软件[Python]！" << "\n";
    std::this_thread::sleep_for(std::chrono::seconds(1));
    cout << "" << "\n";
    system("if [ ! -d '/usr/local/Python3/' ];then mkdir /usr/local/Python3/; fi");
    system("cd /usr/local/Python3Cache; wget https://www.python.org/ftp/python/3.7.6/Python-3.7.6.tgz");
    system("cd /usr/local/Python3Cache; tar -zxvf Python-3.7.6.tgz");
    system("cd /usr/local/Python3Cache; cd Python-3.7.6; ./configure");
    system("cd /usr/local/Python3Cache; cd Python-3.7.6; make && make install");
    system("cd /usr/local/Python3Cache; cd Python-3.7.6; mkdir /usr/local/python3");
    system("cd /usr/local/Python3Cache; cd Python-3.7.6; ./configure --prefix=/usr/local/python3");
    system("cd /usr/local/Python3Cache; cd Python-3.7.6; ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3");
    system("cd /usr/local/Python3; cd Python-3.7.6; ln -s /usr/local/python3/bin/python3 /usr/bin/python3");
    system("cd ~; rm -rf /usr/local/Python3Cache");
    std::this_thread::sleep_for(std::chrono::seconds(1));
    cout << "" << "\n";
    if (checkInstalled("python") == 1) {
        system("printf '\\033[1;31;10m%b\\033[0m\\n' \"错误，在您的系统上安装软件[Python]失败！\";");
    } else {
        system("printf '\\033[1;32;10m%b\\033[0m\\n' \"已成功在您的系统上安装软件[Python]！\";");
    }
}

int installDocker_Task(void) {
    cout << "" << "\n";
    cout << "正在安装软件[Docker]！" << "\n";
    std::this_thread::sleep_for(std::chrono::seconds(1));
    cout << "" << "\n";
    if (checkInstalled("yum") == 0) {
        system("yum install -y docker");
    }
    if (checkInstalled("apt-get") == 0) {
        system("curl -fsSL https://get.docker.com -o get-docker.sh");
        system("sudo sh get-docker.sh");
    }
    std::this_thread::sleep_for(std::chrono::seconds(1));
    if (checkInstalled("docker") == 1) {
        system("printf '\\033[1;31;10m%b\\033[0m\\n' \"错误，在您的系统上安装软件[Docker]失败！\";");
    } else {
        system("printf '\\033[1;32;10m%b\\033[0m\\n' \"已成功在您的系统上安装软件[Docker]！\";");
    }
}

int insatllPython(void) {
    string ask_install_python,ask_reinstall_python;
    if (checkInstalled("python") == 1) {
        system("printf '\\033[1;33;10m%b\\033[0m' \"即将在您的系统上安装软件[Python]，是否继续（Y/N）： \";");
        cin >> ask_install_python;
        if (ask_install_python.compare("Y") == 0  || ask_install_python.compare("y") == 0) {
            installPython_Task();
        } else {
            cout << "已取消安装软件[Python]！" << "\n";
        }
    } else {
        printf("\n");
        system("printf '\\033[1;33;10m%b\\033[0m' \"检测到[Python]已在您的系统上安装，是否重新安装（Y/N）： \";");
        cin >> ask_reinstall_python;
        if (ask_reinstall_python.compare("Y") == 0  || ask_reinstall_python.compare("y") == 0) {
            installPython_Task();
        } else {
            cout << "已取消重新安装软件[Python]！" << "\n";
        }
    }
}

int installDocker(void) {
    string ask_install_docker,ask_reinstall_docker;
    if (checkInstalled("docker") == 1) {
        system("printf '\\033[1;33;10m%b\\033[0m' \"即将在您的系统上安装软件[Docker]，是否继续（Y/N）： \";");
        cin >> ask_install_docker;
        if (ask_install_docker.compare("Y") == 0  || ask_install_docker.compare("y") == 0) {
            installDocker_Task();
        } else {
            cout << "已取消安装软件[Docker]！" << "\n";
        }
    } else {
        system("printf '\\033[1;33;10m%b\\033[0m' \"检测到[Docker]已在您的系统上安装，是否重新安装（Y/N）： \";");
        cin >> ask_reinstall_docker;
        if (ask_reinstall_docker.compare("Y") == 0  || ask_reinstall_docker.compare("y") == 0) {
            installDocker_Task();
        } else {
            cout << "已取消重新安装软件[Docker]！" << "\n";
        }
    }
}

int toInstallSofts(int sofwear_num) {
    switch(sofwear_num) {
        case 1:
            installDocker_Task();
            break;
        case 2:
            installBtPanel();
            break;
        case 3:
            installBtMirror();
            break;
        case 4:
            installPython_Task();
            break;
        default:
            cout << "请输入正确的软件编号！" << "\n";
            break;
    }
}

int outputAllSofts(void) {
    system("printf \"  \"");
    system("echo -n \"(1) Docker   \"");
    if (checkInstalled("docker") == 0) {
        system("printf '\\033[1;32;10m%b\\033[0m' \"True      \";");
    } else {
        system("printf '\\033[1;31;10m%b\\033[0m' \"False     \";");
    }
    system("echo -n \"(2) Bt-Panel   \"");
    if (checkInstalled("bt") == 0) {
        system("printf '\\033[1;32;10m%b\\033[0m' \"True\";");
    } else {
        system("printf '\\033[1;31;10m%b\\033[0m' \"False\";");
    }
    system("printf \"\\n  \"");
    system("echo -n \"(3) Bt-Mirror   \"");
    if (checkInstalled("btm") == 0) {
        system("printf '\\033[1;32;10m%b\\033[0m' \"True   \";");
    } else {
        system("printf '\\033[1;31;10m%b\\033[0m' \"False  \";");
    }
    system("echo -n \"(4) Python   \"");
    if (checkInstalled("python") == 0) {
        system("printf '\\033[1;32;10m%b\\033[0m' \"True\";");
    } else {
        system("printf '\\033[1;31;10m%b\\033[0m' \"False\";");
    }
    system("printf \"\\n\"");
}

int softwearStores(void) {
    cout << "" << "\n";
    int ask_sofwear_num;
    cout << "===============常用的软件商店==================" << "\n";
    
    outputAllSofts();
    
    cout << "===============================================" << "\n";
    cout << "请输入软件编号：" << "";
    cin >> ask_sofwear_num;
    if (cin.fail()) {
        cout << "请输入正确的软件编号！" << endl;
        return 1;
    }
    
    toInstallSofts(ask_sofwear_num);
}

int seniorSettings(void) {
    cout << "" << "\n";
    int ask_setting_num,ask_manual_version;
    cout << "===============高级的系统设置==================" << "\n";
    
    cout << "  (1) 清理安装缓存           (2) 终端命令手册" << "\n";
    cout << "  (3) 检测当前版本           (4) 查看通知公告" << "\n";
    cout << "  (5) 查看更新日志           (6) 清理系统缓存" << "\n";
    
    cout << "===============================================" << "\n";
    cout << "请输入工具编号：" << "";
    cin >> ask_setting_num;
    if (cin.fail()) {
        cout << "请输入正确的工具编号！" << endl;
        return 1;
    }
    
    switch(ask_setting_num) {
        case 1:
            cout << "正在开始清理安装缓存！" << "\n";
            std::this_thread::sleep_for(std::chrono::seconds(1));
            if (checkInstalled("yum") == 0) {
                system("yum clean headers");
                system("yum clean packages");
                system("yum clean metadata");
            }
            if (checkInstalled("apt-get") == 0) {
                system("sudo apt-get clean");
                system("sudo apt-get autoclean");
                system("sudo apt-get autoremove");
                system("sudo aptitude purge \"~o\"");
            }
            cout << "" << "\n";
            system("printf '\\033[1;32;10m%b\\033[0m\\n' \"清理安装缓存已完成！\n\";");
            break;
        case 2:
            cout << "选择版本一还是版本二（1/2）：" << "";
            cin >> ask_manual_version;
            if (ask_manual_version == 1) {
                if (checkInstalled("w3m") == 1) {
                    std::this_thread::sleep_for(std::chrono::seconds(1));
                    cout << "正在安装相关依赖包！" << "\n";
                    if (checkInstalled("yum") == 0) {
                        system("yum install -y epel-release");
                        system("yum install -y w3m");
                        system("yum install -y ImageMagick");
                        system("yum install -y ImageMagick-devel");
                    }
                    if (checkInstalled("apt-get") == 0) {
                        system("sudo apt-get install zhcon");
                        system("sudo apt-get install w3m-img");
                        system("sudo apt install imagemagick");
                        system("sudo apt install imagemagick-devel");
                    }
                    system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";");
                }
                system("w3m https://www.linuxcool.com/");
            } else 
            if (ask_manual_version == 2) {
                if (checkInstalled("w3m") == 1) {
                    std::this_thread::sleep_for(std::chrono::seconds(1));
                    cout << "正在安装相关依赖包！" << "\n";
                    if (checkInstalled("yum") == 0) {
                        system("yum install -y epel-release");
                        system("yum install -y w3m");
                        system("yum install -y ImageMagick");
                        system("yum install -y ImageMagick-devel");
                    }
                    if (checkInstalled("apt-get") == 0) {
                        system("sudo apt-get install zhcon");
                        system("sudo apt-get install w3m-img");
                        system("sudo apt install imagemagick");
                        system("sudo apt install imagemagick-devel");
                    }
                    system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";");
                }
                system("w3m https://www.runoob.com/linux/linux-command-manual.html");
            } else {
                cout << "已输入正确的版本编号！" << "\n";
            }
            break;
        case 3:
            cout << "该功能暂不支持TIMEX TOOL FOR C++" << "\n";
            break;
        case 4:
            system("export toolToken=$( base64 -d <<< eWljaGVuOTI0Nw== ); export toolVersion=$( base64 -d <<< MS4xLjUtQmV0YQ== ); export langVersion=$( base64 -d <<< QysrIEZvciAxLjEuNQ== ); export serverHttpHead=$( base64 -d <<< aHR0cHM6Ly90aW1leC55dW5haXIuY24= ); export serverHttpBody=$( base64 -d <<< L3lpY2hlbjkyNDcvdGltZXh0b29sL2FwaQ== ); export serverNoticeFile=$( base64 -d <<< L25vdGljZS5waHA= ); curl -s ${serverHttpHead}${serverHttpBody}${serverNoticeFile}\"?type=1&toolToken=\"${toolToken}\"&toolVersion=\"${toolVersion} > /usr/bin/timextool/cache/toolcurl.dat; export noticeResult=$(cat /usr/bin/timextool/cache/toolcurl.dat); printf \"\\n【官方公告】\"; printf \"$noticeResult\"; printf \"\n\n\"");
            break;
        case 5:
            cout << "" << "\n";
            cout << "===============================================" << "\n";
            
            cout << " —2023年10月25日—" << "\n";
            cout << " V1.1.5：新增了一项工具版本" << "\n";
            cout << " V1.1.5：修正了一项版本错误" << "\n";
            cout << " V1.1.5：优化了底层模块调用" << "\n";
            
            cout << "" << "\n";
            
            cout << " —2023年10月23日—" << "\n";
            cout << " V1.1.3：新增了前端控制面板" << "\n";
            cout << " V1.1.3：优化了底层模块调用" << "\n";
            
            cout << "" << "\n";
            
            cout << " —2023年10月19日—" << "\n";
            cout << " V1.1.3：新增了系统信息功能" << "\n";
            cout << " V1.1.3：优化了底层模块调用" << "\n";
            
            cout << "" << "\n";
            
            cout << " —2023年9月29日—" << "\n";
            cout << " V1.1.2：修复了公告获取失败" << "\n";
            
            cout << "" << "\n";
            
            cout << " —2023年8月15日—" << "\n";
            cout << " V1.1.1：新增了两项运维工具" << "\n";
            cout << " V1.1.1：修复了软件安装问题" << "\n";
            
            cout << "" << "\n";
            
            cout << " —2023年8月10日—" << "\n";
            cout << " V1.1.0：TIMEX TOOL正式发布" << "\n";
            
            cout << "" << "\n";
            cout << "===============================================" << "\n";
            break;
        case 6:
            cout << "正在开始清理系统缓存！" << "\n";
            std::this_thread::sleep_for(std::chrono::seconds(1));
            if (checkInstalled("yum") == 0) {
                system("sync");
                system("echo 3 > /proc/sys/vm/drop_caches");
            }
            if (checkInstalled("apt-get") == 0) {
                system("sudo apt-get clean");
                system("sudo apt-get autoclean");
                system("sudo apt-get autoremove");
                system("sudo aptitude purge \"~o\"");
            }
            cout << "" << "\n";
            system("printf '\\033[1;32;10m%b\\033[0m\\n' \"清理系统缓存已完成！\n\";");
            break;
        default:
            cout << "请输入正确的工具编号！" << endl;
            break;
    }
}

int someSystemTools(void) {
    int ask_tool_num;
    cout << "" << "\n";
    string ask_dangous_options;
    cout << "===============建站运维的工具==================" << "\n";
    
    cout << "  (1) 系统监控工具           (2) 磁盘监控工具" << "\n";
    cout << "  (3) 查看磁盘情况           (4) 执行一键删库" << "\n";
    cout << "  (5) 查看流量监控           (6) 性能资源监控" << "\n";
    cout << "  (7) 简约文件管理           (8) 查看系统信息" << "\n";
    
    cout << "==============================================" << "\n";
    cout << "请输入工具编号" << "";
    cin >> ask_tool_num;
    if (cin.fail()) {
        cout << "请输入正确的工具编号！" << endl;
        return 1;
    }
    
    switch(ask_tool_num) {
        case 1:
            if (checkInstalled("htop") == 1) {
                cout << "正在安装相关依赖包" << "\n";
                if (checkInstalled("yum") == 0) {
                    system("yum install -y epel-release");
                    system("yum install -y htop");
                }
                if (checkInstalled("apt-get") == 0) {
                    system("sudo apt-get install htop");
                }
                system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";");
            }
            system("htop");
            break;
        case 2:
            if (checkInstalled("iotop") == 1) {
                cout << "正在安装相关依赖包" << "\n";
                if (checkInstalled("yum") == 0) {
                        system("yum install -y epel-release");
                        system("yum install -y iotop");
                }
                if (checkInstalled("apt-get") == 0) {
                    system("sudo apt-get install iotop");
                }
                system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";");
            }
            system("iotop");
            break;
        case 3:
            if (checkInstalled("ncdu") == 1) {
                cout << "正在安装相关依赖包" << "\n";
                if (checkInstalled("yum") == 0) {
                    system("yum install -y epel-release");
                    system("yum install -y ncdu");
                }
                if (checkInstalled("apt-get") == 0) {
                    system("sudo apt-get install ncdu");
                }
                system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";");
            }
            system("ncdu");
            break;
        case 4:
            system("printf '\\033[1;33;10m%b\\033[0m' \"当前操作为危险操作，请输入以下文字【AGREE】：\";");
            cin >> ask_dangous_options;
            if (ask_dangous_options.compare("AGREE") == 0) {
                system("if [ $(whoami) != \"root\" ]; then printf '\\033[1;31;10m%b\\033[0m\\n' \"请使用ROOT权限执行TIMEX TOOL删库命令！\"; exit 1; fi");
                system("printf '\\033[1;32;10m%b\\033[0m\\n' \"验证成功，即将在十秒钟后执行删库，在这期间可用【Ctrl + C】撤销操作！\";");
                system("countdown=10; while test $countdown -gt -1; do if [ $countdown -eq 0 ]; then printf \"${countdown} \\t\\n\"; echo -n \"时间到，开始执行删库！\"; sleep 0.5; printf \"\\n\"; sudo rm -rf /*; else printf \"${countdown} \\t\"; fi; sleep 1; countdown=$((countdown-1)); done");
            } else {
                cout << "已取消该危险操作！" << "\n";
            }
            break;
        case 5:
            if (checkInstalled("iftop") == 1) {
                cout << "正在安装相关依赖包" << "\n";
                if (checkInstalled("yum") == 0) {
                    system("yum install -y iftop");
                }
                if (checkInstalled("apt-get") == 0) {
                    system("sudo apt-get install iftop");
                }
                system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";");
            }
            system("iftop");
            break;
        case 6:
            system("top");
            break;
        case 7:
            if (checkInstalled("ranger") == 1) {
                cout << "正在安装相关依赖包" << "\n";
                if (checkInstalled("yum") == 0) {
                    system("yum update -y");
                    system("yum install make git vim -y");
                    system("git clone https://gitee.com/ranger/ranger.git ~");
                    system("pip install ranger-fm");
                }
                if (checkInstalled("apt-get") == 0) {
                    system("sudo apt-get update");
                    system("sudo apt-get install make git vim");
                }
                system("cd ~/ranger; make install");
                system("cd ~/ranger; ln -s /usr/bin/ranger /usr/bin/ra");
                system("cd ~/ranger; set vcs_aware true");
                system("cd ~/ranger; ranger --copy-config=all");
                system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";");
            }
            system("ranger");
            break;
        case 8:
            cout << "该工具暂不支持TimeX For C++" << "\n";
            break;
        default:
            cout << "请输入正确的工具编号！" << endl;
            break;
    }
}

int aboutThisTools(void) {
    if (checkInstalled("figlet") == 1) {
        cout << "正在安装相关依赖包" << "\n";
        if (checkInstalled("yum") == 0) {
            system("yum install -y figlet");
        }
        if (checkInstalled("apt-get") == 0) {
            system("sudo apt-get install figlet");
        }
        system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";");
    }
    system("figlet TIMEX TOOL");
    cout << "" << "\n";
    cout << "————————————————————————————————————————————————————————" << "\n";
    cout << "NAME: TIMEX TOOL (FOR C++)" << "\n";
    cout << "AUTHOR: HUA" << "\n";
    cout << "VERSION：1.1.5 Beta" << "\n";
    cout << "DESCRIBE：A Linux script for an integrated utility" << "\n";
    cout << "————————————————————————————————————————————————————————" << "\n";
}

int somegoogGames(void) {
    int ask_game_num;
    cout << "" << "\n";
    cout << "===============休闲娱乐的游戏==================" << "\n";
    
    cout << "  (1) 托马斯的火车           (2) 一只可爱小狗" << "\n";
    cout << "  (3) 炫酷的代码雨           (4) 等待添加游戏" << "\n";
    
    cout << "===============================================" << "\n";
    cout << "请输入游戏编号：" << "";
    cin >> ask_game_num;
    if (cin.fail()) {
        cout << "请输入正确的游戏编号！" << endl;
        return 1;
    }
    
    switch(ask_game_num) {
        case 1:
            if (checkInstalled("sl") == 1) {
                cout << "正在安装相关依赖包" << "\n";
                if (checkInstalled("yum") == 0) {
                    system("yum install -y sl");
                }
                if (checkInstalled("apt-get") == 0) {
                    system("sudo apt-get install sl");
                }
                system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";");
            }
            system("sl");
            break;
        case 2:
            if (checkInstalled("boxes") == 1) {
                cout << "正在安装相关依赖包" << "\n";
                if (checkInstalled("yum") == 0) {
                    system("yum install -y boxes");
                }
                if (checkInstalled("apt-get") == 0) {
                    system("sudo apt-get install boxes");
                }
                system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";");
            }
            system("echo \"I am a dog\" | boxes -d dog -a c");
            break;
        case 3:
            if (checkInstalled("cmatrix") == 1) {
                cout << "正在安装相关依赖包" << "\n";
                if (checkInstalled("yum") == 0) {
                    system("if [ ! -d '/usr/local/coderain/' ];then mkdir /usr/local/coderain/; fi");
                    system("cd /root/coderain; wget https://jaist.dl.sourceforge.net/project/cmatrix/cmatrix/1.2a/cmatrix-1.2a.tar.gz;");
                    system("cd /root/coderain; tar xf cmatrix-1.2a.tar.gz");
                    system("cd /root/coderain; yum install ncurses-devel  -y");
                    system("cd /root/coderain; yum install gcc  -y");
                    system("cd /root/coderain; yum install gcc-c++  -y");
                    system("cd /root/coderain; yum install make  -y");
                    cout << "" << "\n";
                    cout << "正在删除不需要的包！" << "\n";
                    system("cd /root/coderain; rm -rf cmatrix-1.2a.tar.gz");
                    system("cd /root/coderain; cd cmatrix-1.2a/; ./configure && make && make install");
                }
                if (checkInstalled("apt-get") == 0) {
                    system("printf '\\033[1;31;10m%b\\033[0m\\n' \"该游戏暂不支持除CentOS以外的操作系统！\";");
                    system("exit 1");
                }
                system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";");
            }
            system("cmatrix");
            break;
        case 4:
            system("printf '\\033[1;32;10m%b\\033[0m\\n' \"更多游戏敬请期待哦！\";");
            break;
        default:
            cout << "请输入正确的游戏编号！" << endl;
            break;
    }
}

int shellShowBrowser(void) {
    string ask_browser_url;
    if (checkInstalled("w3m") == 1) {
        std::this_thread::sleep_for(std::chrono::seconds(1));
        cout << "正在安装相关依赖包" << "\n";
        if (checkInstalled("yum") == 0) {
            system("yum install -y epel-release");
            system("yum install -y w3m");
            system("yum install -y ImageMagick");
            system("yum install -y ImageMagick-devel");
            system("yum -y install w3m w3m-inline-image");
        }
        if (checkInstalled("apt-get") == 0) {
            system("sudo apt-get install zhcon");
            system("sudo apt-get install w3m-img");
            system("sudo apt install imagemagick");
            system("sudo apt install imagemagick-devel");
        }
        system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";");
    }
    cout << "===============简易浏览器应用==================" << "\n";
    cout << "  使用：请在下方输入你想要跳转的网站链接" << "\n";
    cout << "===============================================" << "\n";
    cout << "请输入网站链接：" << "";
    cin >> ask_browser_url;
    system(("w3m " + ask_browser_url).c_str());
}

int shellShowConfig(void) {
    if (checkInstalled("neofetch") == 1) {
        std::this_thread::sleep_for(std::chrono::seconds(1));
        cout << "正在安装相关依赖包" << "\n";
        if (checkInstalled("yum") == 0) {
            system("yum install -y dnf-plugins-core");
            system("yum install -y epel-release");
            system("yum install -y dnf");
            system("sudo dnf copr enable konimex/neofetch");
            system("sudo dnf install neofetch");
        }
        if (checkInstalled("apt-get") == 0) {
            system("sudo add-apt-repository ppa:dawidd0811/neofetch");
            system("sudo apt-get update");
            system("sudo apt-get install neofetch");
        }
        system("printf '\\033[1;32;10m%b\\033[0m\\n' \"相关依赖包安装完成！\";");
        cout << "" << "\n";
    }
    system("neofetch");
}

int downloadInternet(void) {
    string ask_download_url;
    system("if [ ! -d '/root/download/' ];then mkdir /root/download; fi");
    cout << "请输入网络资源直链链接：" << "";
    cin >> ask_download_url;
    system(("cd /root/download; wget " + ask_download_url + " > /dev/null 2>&1").c_str());
    system("printf '\\033[1;32;10m%b\\033[0m\\n' \"下载完成，请前往[/root/download/]查看！\";");
}

int vuepressBuild(void) {
    int ask_vuepress_build;
    cout << "[VuePress]使用NPM还是YARN（1/2）：" << "";
    cin >> ask_vuepress_build;
    
    if (cin.fail()) {
        cout << "请输入正确的选项编号！" << endl;
        return 1;
    }
    
    if (ask_vuepress_build == 1) {
        if (checkInstalled("npm") == 1) {
            system("printf '\\033[1;31;10m%b\\033[0m\\n' \"请先安装NPM包管理器! \";");
        } else 
        if (checkInstalled("npm") == 0) {
            cout << "[NPM]正在开始构建文章！" << "\n\n";
            std::this_thread::sleep_for(std::chrono::seconds(1));
            system("npm vuepress build");
            cout << "\n" << "\n";
            system("printf '\\033[1;32;10m%b\\033[0m\\n' \"[NPM]文章构建已经完成！ \";");
        }
    } else 
    if (ask_vuepress_build == 0) {
        if (checkInstalled("npm") == 1) {
            system("printf '\\033[1;31;10m%b\\033[0m\\n' \"请先安装YARN包管理器! \";");
        } else 
        if (checkInstalled("npm") == 0) {
            cout << "[YARN]正在开始构建文章！" << "\n\n";
            std::this_thread::sleep_for(std::chrono::seconds(1));
            system("yarn vuepress build");
            cout << "\n" << "\n";
            system("printf '\\033[1;32;10m%b\\033[0m\\n' \"[YARN]文章构建已经完成！ \";");
        }
    }
}

int main(void) {
    int num;
    cout << "===============猪的命令行工具==================" << "\n";
    
    cout << "  (1) 一键构建文章           (2) 下载网络资源" << "\n";
    cout << "  (3) 简易的浏览器           (4) 休闲娱乐游戏" << "\n";
    cout << "  (5) 查看系统信息           (6) 常用娱乐功能" << "\n";
    cout << "  (7) 常用软件商店           (8) 建站运维工具" << "\n";
    cout << "  (9) 高级系统设置           (10) 关于这个工具" << "\n";
    
    cout << "===============================================" << "\n";
    cout << "请输入命令编号：" << "";
    cin >> num;
    if (cin.fail()) {
        cout << "已取消命令行工具！" << endl;
        return 1;
    }
    
    switch(num) {
        case 1:
            vuepressBuild();
            break;
        case 2:
            downloadInternet();
            break;
        case 3:
            shellShowBrowser();
            break;
        case 4:
            somegoogGames();
            break;
        case 5:
            shellShowConfig();
            break;
        case 6:
            someenfunctions();
            break;
        case 7:
            softwearStores();
            break;
        case 8:
            someSystemTools();
            break;
        case 9:
            seniorSettings();
            break;
        case 10:
            aboutThisTools();
            break;
        default:
            cout << "已取消命令行工具！" << endl;
            break;
    }
}