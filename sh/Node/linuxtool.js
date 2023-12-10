
const readline = require('readline');
const { exec } = require('child_process');

/*checkInstalled(package).then((code) => {
    return 0;
}).catch((error) => {
    return 1;
});*/

function toolMain() {
    console.log("===============猪的命令行工具==================");
    
    console.log("  (1) 一键构建文章           (2) 下载网络资源");
    console.log("  (3) 简易的浏览器           (4) 休闲娱乐游戏");
    console.log("  (5) 查看系统信息           (6) 常用娱乐功能");
    console.log("  (7) 常用软件商店           (8) 建站运维工具");
    console.log("  (9) 高级系统设置           (10) 关于这个工具");
    
    console.log("===============================================");
    
    const mainInput = readline.createInterface({
       input: process.stdin,
       output: process.stdout
    });
    
    mainInput.question('请输入命令编号：',(num) => {
        getFunction(num);
        mainInput.close();
    })
}

function systemExec(command,printf) {
    const systemc = exec(command,(error, stdout, stderr) => {
        if (error == true) {
        }
    });
    
    if (printf == true) {
        systemc.stdout.on('data', (data) => {
            console.log(data);
        });
    }
}

function getFunction(num) {
    switch(num) {
        case "1":
            installBtPanel();
            break;
        default:
            console.log("已取消命令行工具！");
            break;
    }
}

function checkInstalled(package) {
    return new Promise((resolve, reject) => {
        exec(`type ${package} > /dev/null 2>&1`, (error, stdout, stderr) => {
            if (error) {
                reject(new Error(error));
            } else {
                resolve(0);
            }
        });
    });
}

function checkInstall(curl,apt) {
    checkInstalled("curl").then((code) => {
        if (code == 0) {
            setTimeout(curl,0);
        }
    });
    checkInstalled("apt-get").then((code) => {
        if (code == 0) {
            setTimeout(curl,0);
        }
    });
}

function checkCurlInstall(curl,curlels) {
    checkInstalled("curl").then((code) => {
        if (code == 0) {
            setTimeout(curl,0);
        } else {
            setTimeout(curlels,0);
        }
    });
}

function checkaptGetInstall(apt,aptels) {
    checkInstalled("curl").then((code) => {
        if (code == 0) {
            setTimeout(curl,0);
        } else {
            setTimeout(curlels,0);
        }
    });
}

function installBtPanel() {
    checkInstalled("bt").then((code) => {
        if (code == 0) {
            install();
        } else {
            install();
        }
    }).catch((error) => {
        install();
    });
    
    function install() {
        console.log("正在开始安装宝塔面板！");
        checkCurlInstall(
            () => {
                systemExec("curl -sSO https://download.bt.cn/install/install_btmonitor.sh; bash install_panel.sh ed8484bec",true);
            },
            () => {
                systemExec("wget -O install_btmonitor.sh https://download.bt.cn/install/install_btmonitor.sh; bash install_panel.sh ed8484bec",true);
            }
        );
        systemExec("bash install_panel.sh ed8484bec",true);
    }
}

toolMain();