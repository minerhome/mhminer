# mhminer
挖矿抽水软件测试版  支持windows和ubuntu 20
也可到群里下载, QQ群: 140777161

#### 教学视频  https://www.youtube.com/watch?v=Yu3eOGwn2hU



 
###  已经支持的加密货币  iron  kas    cfx   rxd   dnx  eth(使用eth协议的通用如ethw, ethf等) eth_getwork  etc etc_getwork   alph  nexa  neox(gminer)  xmr(xmrig)  tcc(wildrig)  rvn  ergo flux  sero  etczil etczil_getwork  ethzil ethzil_getwork

### 关于 eth eth_getwork 这两种, 建议两个端口都开起来, 优先使用普通的eth, 有的内核或机器只能使用 eth_getwork,  etc的同理.


##### 开发者抽水,  千3

##### ubuntu使用下面的一键脚本, windows的可以直接下载使用, 只须一个配置文件, 请看config-sample.yml里面的写法, 然后把文件改名为config.yml即可.
##### ubuntu20 默认安装在 /root/mhminer下面,  win则随便你放哪都行.
##### 证书可以自己提供也可以使用默认的. cert.pem  key.pem这两个文件可以自己更换.

##### 矿机可选tcp, ssl, 矿池也可以选tcp, ssl , 且可设置socks5代理, 方便安装在国内.


&nbsp; 香港服务器上执行一键安装脚本
```
bash <(curl -s -L https://raw.githubusercontent.com/minerhome/mhminer/main/scripts/inst.sh)

```








