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






mhminer 配置文件示例  config.yml

```

# 总在线矿机总数量限制
workers_limit: 1000
workers_limit_port: 1000    # 每个端口限制多少台矿机


monitor_config: true    # 监控此配置文件, 下面的端口信息更改,增加或删除或更改, 自动更新
monitor_port: true      # 监控端口异常退出, 异常退出则尝试重复开


# 证书, 亦可不提供使用默认的, 自己提供也行
# 默认放在软件同一个目录, 也可以放在其它目录, 如   /root/mhminer/cert.pem
cert: cert.pem
key: key.pem


servers:

  - name: IRON-英雄-ssl
    ip: 0.0.0.0:17650     # 给客人连接的端口, 前面固定为0.0.0.0
    ssl: true             # 给客人连接, 一般要开ssl
    coin: IRON            # 币种, 参数上面完成的
    pool: # 实际代理矿池
      ip: hk.ironfish.herominers.com:1145     # 英雄池的iron地址
      ssl: false                
      proxy: ""                               # 如果安装在国内, 则这里要填上socks5代理
    devfee: # 可开多个抽水, 可同池也可跨池
      - name: "测试一"
        worker_name: "devfee-1-1"
        fee_percent: 1     # 1%
        address: "你的钱包1"  #  改成你自己的钱包
      - name: "测试二"
        worker_name: "devfee-1-2"
        fee_percent: 2     # 2%
        address: "你的钱包2"  #  改成你自己的钱包


  - name: KAS-毛池-ssl
    ip: 0.0.0.0:16510     # 给客人连接的端口, 前面固定为0.0.0.0
    ssl: true             # 给客人连接, 一般要开ssl
    coin: KAS             # 币种, 参数上面完成的
    pool: # 实际代理矿池
      ip: pool.sg.woolypooly.com:3112    # 毛池的kas地址
      ssl: false
      proxy: ""              # 如果安装在国内, 则这里要填上socks5代理
    devfee: # 跨池抽到英雄池
      - name: "测试一"
        worker_name: "devfee-1-1"
        fee_percent: 1     # 1%
        address: "你的钱包1"  #  改成你自己的钱包
        pool: # 跨池抽到哪
            ip: hk.kaspa.herominers.com:1206
            ssl: false               # 矿池一般选择tcp
            proxy: ""                # 如果安装在国内, 则这里要填上socks5代理:端口




  - name: 服务端解密 - 鱼池btc
    encrypt: true        # 服务端解密, 把本地端发来的数据解密再发给矿池
    ip: 0.0.0.0:14881    # 解密本地端发来的数据, 端口要对应
    coin: BTC
    pool:            
      ip:  btc-asia.f2pool.com:1314  #  鱼池的BTC地址
      ssl: false
    devfee: 
      - name: 抽水1                
        worker_name: "devfee-1-20230511"
        fee_percent: 1     # 1%
        address: "你的抽水钱包"  # 改成你自己的钱包




```

