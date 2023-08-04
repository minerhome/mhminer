# mhtunnel  本地加密
要跟 mhminer配合使用, 本地加密之后发往mhminer服务器解密. 针对专业机, 如btc, ltc等专业机.
hiveos使用一键安装脚本, win则可以直接下载运行.



&nbsp; hiveos 安装
```
bash <(curl -s -L https://ghproxy.com/https://raw.githubusercontent.com/minerhome/mhminer/main/scripts/inst.sh)


```





配置文件 config.yml

```

# 本地加密端配置文件


global_ip: ""           # 本地加密端专用, 指定专线ip, 否则走公用服务器


# 总在线矿机总数量限制
workers_limit: 1000
workers_limit_port: 1000    # 每个端口限制多少台矿机


monitor_config: true    # 监控此配置文件, 下面的端口信息更改,增加或删除或更改, 自动更新
monitor_port: true      # 监控端口异常退出, 异常退出则尝试重复开


servers:
  - name: IRON-鱼池-tcp
    ip: 0.0.0.0:42281     # 本地局域网给客人连接的端口, 42280
    encrypt: true         # 是否使用加密, 本地端表示加密, 服务端表示解密, 服务端只接收加密数据, 没有写pool, 默认使用服务器的52280端口, 即+10000
    pool:                 # 发给自己的服务端解密
      ip: 你的服务器IP:52281       


  - name: IRON-英雄-tcp
    ip: 0.0.0.0:42280     # 本地局域网给客人连接的端口, 42280
    encrypt: true         # 是否使用加密, 本地端表示加密, 服务端表示解密, 服务端只接收加密数据, 没有写pool, 默认使用服务器的52280端口, 即+10000


```








