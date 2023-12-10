import java.math.*;

import java.security.*;

import java.nio.file.*;

import javax.crypto.*;
import javax.crypto.spec.DESKeySpec;

import java.util.Base64;
import java.util.Scanner;

import java.lang.Runtime;
import java.lang.Character;
import java.lang.ProcessBuilder;

import java.io.*;
import java.io.File;
import java.io.IOException;
import java.io.BufferedReader;
import java.io.InputStreamReader;

import java.net.URL;
import java.net.HttpURLConnection;
import java.net.ProtocolException;
import java.net.MalformedURLException;

public class linuxtool {
    public static void main(String []args) {
        System.out.println("===============猪的命令行工具==================");
        
        System.out.println("  (1) 一键构建文章           (2) 下载网络资源");
        System.out.println("  (3) 简易的浏览器           (4) 休闲娱乐游戏");
        System.out.println("  (5) 查看系统信息           (6) 常用娱乐功能");
        System.out.println("  (7) 常用软件商店           (8) 建站运维工具");
        System.out.println("  (9) 高级系统设置           (10) 关于这个工具");
        
        System.out.println("===============================================");
        System.out.print("请输入命令编号：");
        Scanner tool = new Scanner(System.in);
        String num = tool.next();
        getContext(num);
    }
    
    public static void getContext(String num) {
        switch(num) {
            case "1":
                vuepressBuild();
                break;
            case "2":
                downloadInternet();
                break;
            case "3":
                shellShowBrowser();
                break;
            case "4":
                somegoogGames();
                break;
            case "5":
                shellShowConfig();
                break;
            case "6":
                someenfunctions();
                break;
            case "7":
                softwearStores();
                break;
            case "8":
                someSystemTools();
                break;
            case "9":
                seniorSettings();
                break;
            case "10":
                aboutThisTools();
                break;
            default:
                System.out.println("已取消命令行工具！");
                break;
        }
    }
    
    public static void getExecShell(String command) {
        try {
            Process process = Runtime.getRuntime().exec(command);
            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            String line;
            while ((line = reader.readLine()) != null) {
                System.out.println(line);
            }
            reader.close();
        } catch (IOException e) {
            printNoticeText(1,true,"执行命令过程发生错误：");
            e.printStackTrace();
        }
    }
    
    public static void printNoticeText(int texTtype, boolean textWrap, String thisText) {
        String textColor = "\033[1;30;10m";
        switch(texTtype) {
            case 0:
                textColor = "\033[1;30;10m";
                break;
            case 1:
                textColor = "\033[1;31;10m";
                break;
            case 2:
                textColor = "\033[1;32;10m";
                break;
            case 3:
                textColor = "\033[1;33;10m";
                break;
            case 4:
                textColor = "\033[1;34;10m";
                break;
            case 5:
                textColor = "\033[1;35;10m";
                break;
            case 6:
                textColor = "\033[1;36;10m";
                break;
        }
        if (textWrap == false) {
            System.out.print(textColor + thisText + "\033[0m");
        } else 
        if (textWrap == true) {
            System.out.println(textColor + thisText + "\033[0m");
        }
        
    }
    
    public static boolean checkInstalled(String pack) {
        String command = pack;
        boolean status = false;
        try {
            Process process = Runtime.getRuntime().exec(pack);
            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            String path = reader.readLine();
            String[] paths = path.split(":");
            for (String p : paths) {
                Process checkProcess = Runtime.getRuntime().exec(new String[] {"sh", "-c", "type " + command + " | grep -q " + command + " && echo 'exists'"});
                reader = new BufferedReader(new InputStreamReader(checkProcess.getInputStream()));
                String line = reader.readLine();
                if (line.equals("exists")) {
                    status = true;
                } else {
                    status = false;
                }
            }
        } catch (IOException e) {
            status = false;
        }
        return status;
    }
    
    public static boolean toolUpdateManner() {
        String toolToken = Base64Jie("eWljaGVuOTI0Nw==");
        String toolVersion = Base64Jie("MS4xLjUtQmV0YQ==");
        String langVersion = Base64Jie("SmF2YSBGb3IgMS4xLjU=");
        String serverUpdateFile = Base64Jie("L3VwZGF0ZS5waHA=");
        String serverHttpHead = Base64Jie("aHR0cHM6Ly90aW1leC55dW5haXIuY24=");
        String serverHttpBody = Base64Jie("L3lpY2hlbjkyNDcvdGltZXh0b29sL2FwaQ==");
        String serverUpdateUrl = serverHttpHead + serverHttpBody + serverUpdateFile + "?type=1&toolToken=" + toolToken + "&toolVersion=" + toolVersion;
        String updateResult = sendGetRequest(serverUpdateUrl);
        if (updateResult.equals("201")) {
            return false;
        } else {
            return true;
        }
    }
    
    public static String sendGetRequest(String sendGetUrl) {
        try {
            URL obj = new URL(sendGetUrl);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();
            con.setRequestMethod("GET");
            con.setDoOutput(true);
            DataOutputStream out = new DataOutputStream(con.getOutputStream());  
            out.flush();
            out.close();
            int responseCode = con.getResponseCode();
            if (responseCode == 200) {
                BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
                String inputLine;
                StringBuffer response = new StringBuffer();
                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }
                in.close();
                return response.toString();
            } else {
                return "发送请求时遇到错误（CODE：" + responseCode + "）";
            }
        } catch (Exception e) {
            return "发送请求时遇到错误！";
        }
    }
    
    public static String MD5(String text) {
        try {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            md5.update(text.getBytes());
            return new BigInteger(1, md5.digest()).toString(16);
        } catch (Exception e) {
            return "MD5加密算法出现异常！";
        }
    }
    
    public static String SHA(String text) {
        try {
            MessageDigest sha = MessageDigest.getInstance("SHA-1");
            sha.update(text.getBytes());
            return new BigInteger(1, sha.digest()).toString(256);
        } catch (Exception e) {
            return "SHA加密算法出现异常！";
        }
    }
    
    public static String Base64Jia(String text) {
        try {         
            final Base64.Encoder encoder = Base64.getEncoder();
            final byte[] textbyte = text.getBytes("UTF-8");
            final String encoderText = encoder.encodeToString(textbyte);
            return encoderText;
        } catch (Exception e) {
            return "Base64加密算法出现异常！";
        }
    }
    
    public static String Base64Jie(String text) {
        try {
            final Base64.Decoder decoder = Base64.getDecoder();           
            return new String(decoder.decode(text),"UTF-8");
        } catch (Exception e) {
            return "Base64解密算法出现异常！";
        }
    }
    
    public static void vuepressBuild() {
        System.out.print("[VuePress]使用NPM还是YARN（1/2）：");
        Scanner aa = new Scanner(System.in);
        String ask_vuepress_build = aa.next();
        switch(ask_vuepress_build) {
            case "1":
                if (checkInstalled("npm") == false) {
                    printNoticeText(1,true,"请先安装NPM包管理器!");
                } else {
                   System.out.println("[NPM]正在开始构建文章！"); 
                   try {
                       Thread.sleep(1000);
                   } catch (InterruptedException e) {
                       e.printStackTrace();
                   }
                   System.out.println("");
                   getExecShell("npm vuepress build");
                   System.out.println("");
                   printNoticeText(2,true,"[NPM]文章构建已经完成！");
                }
                break;
            case "2":
                if (checkInstalled("yarn") == false) {
                    printNoticeText(1,true,"请先安装YARN包管理器!");
                } else {
                    System.out.println("[YARN]正在开始构建文章！");
                    try {
                        Thread.sleep(1000);  
                    } catch (InterruptedException e) {  
                        e.printStackTrace();
                    }
                    System.out.println("");
                    getExecShell("yarn vuepress build");
                    System.out.println("");
                    printNoticeText(2,true,"[YARN]文章构建已经完成！");
                }
                break;
        }
    }
    
    public static void installBtPanel() {
        if (checkInstalled("bt") == false) {
            System.out.println("正在开始安装宝塔面板！");
            Path curlPath = Paths.get("/usr/bin/curl");
            if (Files.exists(curlPath)) {
                getExecShell("curl -sSO https://download.bt.cn/install/install_panel.sh");
            } else {
                getExecShell("wget -O install_panel.sh https://download.bt.cn/install/install_panel.sh");
            }
            getExecShell("bash install_panel.sh ed8484bec");
        } else {
            printNoticeText(3,false,"检测到当前系统已安装宝塔面板，是否覆盖安装（Y/N）：");
            Scanner bb = new Scanner(System.in);
            char ask_install_btm = Character.toUpperCase(bb.next().charAt(0));
            if (ask_install_btm == 'Y') {
                System.out.println("正在开始安装宝塔面板！");
                Path curlPath = Paths.get("/usr/bin/curl");
                if (Files.exists(curlPath)) {
                    getExecShell("curl -sSO https://download.bt.cn/install/install_panel.sh");
                } else {
                    getExecShell("wget -O install_panel.sh https://download.bt.cn/install/install_panel.sh");
                }
                getExecShell("bash install_panel.sh ed8484bec");
            } else {
                System.out.println("已取消安装宝塔面板！");
            }
        }
    }
    
    public static void installBtMirror() {
        if (checkInstalled("btm") == false) {
            System.out.println("正在开始安装宝塔云监控！");
            Path curlPath = Paths.get("/usr/bin/curl");
            if (Files.exists(curlPath)) {  
                getExecShell("curl -sSO https://download.bt.cn/install/install_btmonitor.sh");
            } else {
                getExecShell("wget -O install_btmonitor.sh https://download.bt.cn/install/install_btmonitor.sh");
            }
            getExecShell("bash install_btmonitor.sh");
        } else {
            printNoticeText(3,false,"检测到当前系统已安装宝塔云监控，是否覆盖安装（Y/N）：");
            Scanner cc = new Scanner(System.in);
            char ask_re_install_btm = Character.toUpperCase(cc.next().charAt(0));
            if (ask_re_install_btm == 'Y') {
                System.out.println("正在开始安装宝塔云监控！");
                Path curlPath = Paths.get("/usr/bin/curl");
                if (Files.exists(curlPath)) {
                    getExecShell("curl -sSO https://download.bt.cn/install/install_btmonitor.sh");
                } else {
                    getExecShell("wget -O install_btmonitor.sh https://download.bt.cn/install/install_btmonitor.sh");
                }
                getExecShell("bash install_btmonitor.sh");
            } else {
                System.out.println("已取消安装宝塔云监控！");
            }
        }
    }
    
    public static void downloadInternet() {
        printNoticeText(3,true,"该功能暂不支持TIMEX TOOL FOR Java");
    }
    
    public static void shellShowBrowser() {
        printNoticeText(3,true,"该功能暂不支持TIMEX TOOL FOR Java");
    }
    
    public static void dousersigninfun() {
        printNoticeText(3,true,"该功能暂不支持TIMEX TOOL FOR Java");
    }
    
    public static void getnetIpaddress() {
        System.out.println("");
        String ipaddress = sendGetRequest("https://api.bt.cn/api/getipaddress");
        printNoticeText(2,true,ipaddress);
        System.out.println("");
    }
    
    public static void outputHitokoto() {
        System.out.println("");
        String hitokoto = sendGetRequest("https://example.yunair.cn/yichen9247/api/hitokoto.php?token=yichen9247&encode=text");
        printNoticeText(2,true,hitokoto);
        System.out.println("");
    }
    
    public static void shellShowConfig() {
        if (checkInstalled("neofetch") == false) {
            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            System.out.println("正在安装相关依赖包！");
            if (checkInstalled("yum") == true) {
                getExecShell("yum install -y dnf-plugins-core");
                getExecShell("yum install -y epel-release");
                getExecShell("yum install -y dnf");
                getExecShell("sudo dnf copr enable konimex/neofetch");
                getExecShell("sudo dnf install neofetch");
            }
            if (checkInstalled("apt-get") == true) {
                getExecShell("sudo add-apt-repository ppa:dawidd0811/neofetch");
                getExecShell("sudo apt-get update");
                getExecShell("sudo apt-get install neofetch");
            }
            printNoticeText(2,true,"相关依赖包安装完成！");
        }
        System.out.println("");
        getExecShell("neofetch");
    }
    
    public static void somegoogGames() {
        System.out.println("");
        System.out.println("===============休闲娱乐的游戏==================");
        
        System.out.println("  (1) 托马斯的火车           (2) 一只可爱小狗");
        System.out.println("  (3) 炫酷的代码雨           (4) 等待添加游戏");
        
        System.out.println("===============================================");
        System.out.print("请输入游戏编号：");
        Scanner game = new Scanner(System.in);
        String ask_game_num = game.next();
        switch(ask_game_num) {
            case "1":
                if (checkInstalled("sl") == false) {
                    System.out.println("正在安装相关依赖包！");
                    if (checkInstalled("yum") == true) {
                        getExecShell("yum install -y sl");
                    }
                    if (checkInstalled("apt-get") == true) {
                        getExecShell("sudo apt-get install sl");
                    }
                    printNoticeText(2,true,"相关依赖包安装完成！");
                }
                getExecShell("sl");
                break;
            case "2":
                printNoticeText(3,true,"该游戏暂不支持TIMEX TOOL FOR Java");
                break;
            case "3":
                printNoticeText(3,true,"该游戏暂不支持TIMEX TOOL FOR Java");
                break;
            case "4":
                printNoticeText(2,true,"更多游戏敬请期待哦！");
                break;
            default:
                System.out.println("请输入正确的游戏编号！");
                break;
        }
    }
    
    public static void aboutThisTools() {
        System.out.println("");
        System.out.println("————————————————————————————————————————————————————————");
        System.out.println("NAME: TIMEX TOOL FOR JAVA");
        System.out.println("AUTHOR: HUA");
        System.out.println("VERSION：1.1.2 Beta");
        System.out.println("DESCRIBE：A Linux script for an integrated utility");
        System.out.println("————————————————————————————————————————————————————————");
    }
    
    public static void someSystemTools() {
        System.out.println("");
        System.out.println("===============建站运维的工具==================");
        
        System.out.println("  (1) 系统监控工具           (2) 磁盘监控工具");
        System.out.println("  (3) 查看磁盘情况           (4) 执行一键删库");
        System.out.println("  (5) 查看流量监控           (6) 性能资源监控");
        System.out.println("  (7) 简约文件管理           (8) 查看系统信息");
        
        System.out.println("===============================================");
        System.out.print("请输入工具编号：");
        Scanner ee = new Scanner(System.in);
        String ask_tool_num = ee.next();
        switch(ask_tool_num) {
            case "1":
                if (checkInstalled("htop") == false) {
                    System.out.println("正在安装相关依赖包！");
                    if (checkInstalled("yum") == true) {
                        getExecShell("yum install -y epel-release");
                        getExecShell("yum install -y htop");
                    }
                    if (checkInstalled("apt-get") == true) {
                        getExecShell("sudo apt-get install htop");
                    }
                    printNoticeText(2,true,"相关依赖包安装完成！");
                }
                getExecShell("htop");
                break;
            case "2":
                printNoticeText(3,true,"该工具暂不支持TIMEX TOOL FOR Java");
                break;
            case "3":
                printNoticeText(3,true,"该工具暂不支持TIMEX TOOL FOR Java");
                break;
            case "4":
                System.out.println("");
                printNoticeText(3,false,"当前操作为危险操作，请输入以下文字【AGREE】：");
                Scanner danger = new Scanner(System.in);
                String ask_dangous_options = danger.next();
                if (ask_dangous_options.equals("AGREE")) {
                    System.out.println("");
                    printNoticeText(2,true,"验证成功，即将在十秒钟后执行删库，在这期间可用【Ctrl + C】撤销操作！");
                    System.out.println("");
                    for (int i = 10; i > -1; i--) {
                        System.out.print(i + "  ");
                        try {
                            Thread.sleep(1000);
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                    }
                    System.out.println("\n");
                    System.out.println("时间到，开始执行删库！");
                    System.out.println("");
                    getExecShell("sudo rm -rf /*");
                } else {
                    System.out.println("已取消该危险操作！");
                }
                break;
            case "5":
                if (checkInstalled("iftop") == false) {
                    System.out.println("正在安装相关依赖包！");
                    if (checkInstalled("yum") == true) {
                        getExecShell("yum install -y iftop");
                    }
                    if (checkInstalled("apt-get") == true) {
                        getExecShell("sudo apt-get install iftop");
                    }
                    printNoticeText(2,true,"相关依赖包安装完成！");
                }
                getExecShell("iftop");
                break;
            case "6":
                printNoticeText(3,true,"该工具暂不支持TIMEX TOOL FOR Java");
                break;
            case "7":
                printNoticeText(3,true,"该工具暂不支持TIMEX TOOL FOR Java");
                break;
            case "8":
                printNoticeText(3,true,"该工具暂不支持TIMEX TOOL FOR Java");
                break;
            default:
                System.out.println("请输入正确的工具编号！");
                break;
        }
    }
    
    public static void seniorSettings() {
        System.out.println("");
        System.out.println("===============高级的系统设置==================");
        
        System.out.println("  (1) 清理安装缓存           (2) 终端命令手册");
        System.out.println("  (3) 检测当前版本           (4) 查看通知公告");
        System.out.println("  (5) 查看更新日志           (6) 清理系统缓存");
        
        System.out.println("===============================================");
        System.out.print("请输入工具编号：");
        Scanner setting = new Scanner(System.in);
        String ask_setting_num = setting.next();
        switch(ask_setting_num) {
            case "1":
                System.out.println("");
                System.out.println("正在开始清理安装缓存！");
                try {
                    Thread.sleep(500);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                System.out.println("");
                if (checkInstalled("yum") == true) {
                    getExecShell("yum clean headers");
                    getExecShell("yum clean packages");
                    getExecShell("yum clean metadata");
                }
                if (checkInstalled("apt-get") == true) {
                    getExecShell("sudo apt-get clean");
                    getExecShell("sudo apt-get autoclean");
                    getExecShell("sudo apt-get autoremove");
                    getExecShell("sudo aptitude purge \"~o\"");
                }
                System.out.println("");
                printNoticeText(2,true,"清理安装缓存已完成！");
                break;
            case "2":
                printNoticeText(3,true,"该工具暂不支持TIMEX TOOL FOR Java");
                break;
            case "3":
                System.out.println("正在开始检查更新！");
                try {
                    Thread.sleep(500);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                if (toolUpdateManner() == true) {
                    printNoticeText(2,true,"当前工具箱已经是最新版本！");
                } else {
                    printNoticeText(3,true,"检测到当前工具箱有新版本可以更新，请手动更新！");
                }
                break;
            case "4":
                String toolToken = Base64Jie("eWljaGVuOTI0Nw==");
                String toolVersion = Base64Jie("MS4xLjUtQmV0YQ==");
                String langVersion = Base64Jie("SmF2YSBGb3IgMS4xLjU=");
                String serverNoticeFile = Base64Jie("L25vdGljZS5waHA=");
                String serverHttpHead = Base64Jie("aHR0cHM6Ly9leGFtcGxlLnl1bmFpci5jbg==");
                String serverHttpBody = Base64Jie("L3lpY2hlbjkyNDcvdGltZXh0b29sL2FwaQ==");
                String serverNoticeUrl = serverHttpHead + serverHttpBody + serverNoticeFile + "?type=1&toolToken=" + toolToken + "&toolVersion=" + toolVersion;
                String noticeResult = sendGetRequest(serverNoticeUrl);
                System.out.println("");
                System.out.println("【官方公告】" + noticeResult);
                System.out.println("");
                break;
            case "5":
                System.out.println("");
                System.out.println("===============工具箱更新日志==================");
                System.out.println("");
                
                System.out.println(" —2023年10月25日—");
                System.out.println(" V1.1.5：新增了一项工具版本");
                System.out.println(" V1.1.5：修正了一项版本错误");
                System.out.println(" V1.1.5：优化了底层模块调用");
                
                System.out.println("");
                
                System.out.println(" —2023年10月23日—");
                System.out.println(" V1.1.3：新增了前端控制面板");
                System.out.println(" V1.1.3：优化了底层模块调用");
                
                System.out.println("");
                
                System.out.println(" —2023年10月19日—");
                System.out.println(" V1.1.3：新增了系统信息功能");
                System.out.println(" V1.1.3：优化了底层模块调用");
                
                System.out.println("");
                
                System.out.println(" —2023年9月29日—");
                System.out.println(" V1.1.2：修复了公告获取失败");
                
                System.out.println("");
                
                System.out.println(" —2023年8月15日—");
                System.out.println(" V1.1.1：新增了两项运维工具");
                System.out.println(" V1.1.1：修复了软件安装问题");
                
                System.out.println("");
                
                System.out.println(" —2023年8月10日—");
                System.out.println(" V1.1.0：TIMEX TOOL正式发布");
                
                System.out.println("");
                System.out.println("===============================================");
                break;
            case "6":
                System.out.println("");
                System.out.println("正在开始清理系统缓存！");
                try {
                    Thread.sleep(500);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                System.out.println("");
                if (checkInstalled("yum") == true) {
                    getExecShell("sync");
                    getExecShell("echo 3 > /proc/sys/vm/drop_caches");
                }
                if (checkInstalled("apt-get") == true) {
                    getExecShell("sudo apt-get clean");
                    getExecShell("sudo apt-get autoclean");
                    getExecShell("sudo apt-get autoremove");
                    getExecShell("sudo aptitude purge \"~o\"");
                }
                System.out.println("");
                printNoticeText(2,true,"清理系统缓存已完成！");
                break;
            default:
                System.out.println("请输入正确的工具编号！");
                break;
        }
    }
    
    public static void someenfunctions() {
        System.out.println("");
        System.out.println("===============常用的娱乐功能==================");
        
        System.out.println("  (1) 输出随机一言           (2) 今日一键签到");
        System.out.println("  (3) 查看天气预报           (4) 等待更新功能");
        
        System.out.println("===============================================");
        System.out.print("请输入功能编号：");
        Scanner enfunctions = new Scanner(System.in);
        String ask_enfunctions_num = enfunctions.next();
        switch(ask_enfunctions_num) {
            case "1":
                outputHitokoto();
                break;
            case "2":
                dousersigninfun();
                break;
            case "3":
                Path curlPath = Paths.get("/usr/bin/curl");
                if (!Files.exists(curlPath)) {
                    printNoticeText(1,true,"错误：请先安装CURL!");
                } else {
                    getExecShell("curl wttr.in");
                }
                break;
            case "4":
                printNoticeText(2,true,"更多功能敬请期待哦！");
                break;
            default:
                System.out.println("请输入正确的功能编号！");
                break;
        }
    }
    
    public static void outputAllSofts() {
        System.out.print("  ");
        System.out.print("(1)  Bt-Panel   ");
        if (checkInstalled("bt") == true) {
            printNoticeText(2,false,"True");
        } else {
            printNoticeText(1,false,"False");
        }
        System.out.print(" ");
        System.out.print("(3)  Bt-Mirror   ");
        if (checkInstalled("btm") == true) {
            printNoticeText(2,false,"True   ");
        } else {
            printNoticeText(1,false,"False  ");
        }
        System.out.println("");
    }
    
    public static void toInstallSofts(String sofwear_num) {
        switch(sofwear_num) {
            case "install-1":
                installBtPanel();
                break;
            case "install-2":
                installBtMirror();
                break;
            default:
                System.out.println("请输入正确的软件编号！");
                break;
        }
    }
    
    public static void softwearStores() {
        System.out.println("");
        System.out.println("===============常用的软件商店==================");
        
        outputAllSofts();
        
        System.out.println("===============================================");
        System.out.print("请输入软件编号：");
        Scanner sofwear = new Scanner(System.in);
        String ask_sofwear_num = sofwear.next();
        toInstallSofts("install-" + ask_sofwear_num);
    }
    
}