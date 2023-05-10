# mhencrypt  本地加密
要跟 mhminer配合使用, 本地加密之后发往mhminer服务器解密. 针对专业机, 如btc, ltc等专业机.




配置文件 config.yml

```

# 本地加密端配置文件


# 总在线矿机总数量限制
workers_limit: 1000
workers_limit_port: 1000    # 每个端口限制多少台矿机


monitor_config: true    # 监控此配置文件, 下面的端口信息更改,增加或删除或更改, 自动更新
monitor_port: true      # 监控端口异常退出, 异常退出则尝试重复开


servers:
  - name: 本地端加密 - 鱼池btc
    encrypt: true        # 是否使用加密, 本地端表示加密, 服务端表示解密,
    ip: 0.0.0.0:14881    # 给本地的btc接进来的端口, 矿机通过这个端口连接这台加密机
    pool:
      ip: 8.218.238.31:14881       # 发给自己的服务端解密

```








