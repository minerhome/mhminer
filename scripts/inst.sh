#!/bin/bash

[[ $(id -u) != 0 ]] && echo -e "请使用root权限运行安装脚本， 通过sudo su root切换再来运行" && exit 1



cmd="apt-get"
if [[ $(command -v apt-get) || $(command -v yum) ]] && [[ $(command -v systemctl) ]]; then
    if [[ $(command -v yum) ]]; then
        cmd="yum"
    fi
else
    echo "目前只支持ubuntu 20" && exit 1
fi


start() {
    if netstat -anptl | grep -q "mh_proxy"; then
        echo -e "mh_proxy 已启动,请勿重复启动" && exit 1
    fi
    systemctl start mh_proxy 
    echo "mh_proxy 启动"
}

restart() {
    systemctl restart mh_proxy >> /dev/null
    echo "mh_proxy 重新启动" 
}

stop() {
    systemctl stop mh_proxy >> /dev/null
    echo "mh_proxy 停止" 
}


check_done() {
    if netstat -antpl | grep -q "12510"; then
        echo -e "\n\n" 
        echo -e "--------------------------------------------------------------------"
        echo -e "\n" 
        echo -e "安装成功， mh_proxy  已经在运行......" 
        echo -e "\n" 
        echo -e "---------------------------------------------------------------------"
        echo -e "\n" 
    else        
        echo -e "\n\n" 
        echo "安装不成功，请重启后重新安装"   
        echo "出现各种选择，请按 确认/OK"
        echo -e "\n\n" 
    fi      
}


change_limit(){
    num="n"
    if [ $(grep -c "root soft nofile" /etc/security/limits.conf) -eq '0' ]; then
        echo "root soft nofile 65535" >>/etc/security/limits.conf
        num="y"
    fi

    if [[ "$num" = "y" ]]; then
        echo "连接数限制已修改为 65535, 重启服务器后生效"
    else
        echo -n "当前连接数限制："
        ulimit -n
    fi
}

check_limit(){
    echo -n "当前连接数限制："
    ulimit -n
}

uninstall() {
        # echo "正在卸载......"
        systemctl stop mh_proxy  &
        systemctl disable mh_proxy  >> /dev/null
        rm -rf /root/mh_proxy
        # echo "卸载完记得重启服务器"

        # echo "正在卸载......"
        systemctl stop mhminer  &
        systemctl disable mhminer  >> /dev/null
        rm -rf /root/mhminer
        # echo "卸载完记得重启服务器"

}


install_common() {
    ufw disable
    $cmd update -y
    $cmd install wget -y
    $cmd install net-tools -y
}


install() {
    
    install_common
    
    uninstall   # 先把老的卸载

    rm -rf /root/mhminer
    mkdir /root/mhminer
    cd /root/mhminer

    clear
    echo -e "\n" 
    echo -e "\n" 
    echo -e "\n" 
    echo -e "\n" 
    echo -e "\n" 
    echo -e "\n" 
    echo -e "\n" 
    echo -e "\n" 
    echo "请选择要安装的版本"
    echo "  1、v0.0.1"
    read -p "$(echo -e "请输入[1-?]：")" choose
    case $choose in
    1)
        wget  --no-check-certificate https://raw.githubusercontent.com/minerhome/mhminer/main/0.0.1/mhminer  -O  /root/mhminer/mhminer
        ;;


    *)
        echo "请输入正确的数字"
        ;;
    esac

    wget  --no-check-certificate https://raw.githubusercontent.com/minerhome/mhminer/main/0.0.1/config.yml  -O  /root/mhminer/config.yml
    wget  --no-check-certificate https://raw.githubusercontent.com/minerhome/mhminer/main/0.0.1/config-sample.yml  -O  /root/mhminer/config-sample.yml
    wget  --no-check-certificate https://raw.githubusercontent.com/minerhome/mhminer/main/scripts/mhminer.service    -O  /lib/systemd/system/mhminer.service  
    wget  --no-check-certificate https://raw.githubusercontent.com/minerhome/mhminer/main/scripts/mhminer.sh    -O   /root/mhminer/mhminer.sh 


    chmod +x /root/mhminer/*
    systemctl daemon-reload
    systemctl enable mhminer  >> /dev/null
    systemctl restart mhminer  &    

    clear
    echo -e "\n" 
    echo -e "\n" 
    echo -e "安装结束请修改config.yml文件, 把里面的抽水钱包换成你自己的" 
    echo -e "\n" 
    echo -e "\n" 

    # check_done

}

setup() {

    clear
    echo -e "\n" 
    echo -e "\n" 
    echo -e "\n" 
    echo -e "\n" 
    echo -e "\n" 

    if [[ ! -d /root/mh_proxy ]]; then
        echo
        echo -e "请先安装再来设置"
        exit 1
    fi

    cd /root/mh_proxy
    wget  --no-check-certificate  https://raw.githubusercontent.com/minerhome/mh_tunnel/master/scripts/server/server_setup   -O /root/mh_proxy/server_setup
    chmod +x /root/mh_proxy/*
    clear
    ./server_setup
}



  
clear
echo -e "\n" 
echo -e "\n" 
echo -e "\n" 
echo -e "\n" 
echo -e "\n" 
echo -e "\n" 
echo -e "\n" 
echo -e "\n" 
echo "================================================================================"
echo "minerhome proxy 中转抽水软件  一键安装工具 - 矿工之家https://minerhome.org"
echo "如果安装不成功，则重启服务器后重新安装"
echo "出现各种选择，请按 确认/OK"
echo "  1、安装(默认安装到/root/mhminer) - 安装完记得重启服务器 - 软件开机会自动启动，后台守护运行"
echo "  2、卸载 - 卸载完记得重启服务器"
echo "  3、解除linux系统连接数限制 - 需要重启服务器生效"
echo "  4、查看当前系统连接数限制"
echo "  5、重启服务器"
echo "================================================================================"
read -p "$(echo -e "请选择[1-?]：")" choose
case $choose in
1)
    install
    ;;
3)
    uninstall
    ;;
4)
    change_limit
    ;;
5)
    check_limit
    ;;
6)
    reboot
    ;;
*)
    echo "输入错误请重新输入！"
    ;;
esac