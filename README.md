OpenWrt/LEDE LuCI for KoolProxy
===

前言
---
LuCI 部分待完成
感謝 [koolshare.cn][koolshare] 提供 ```KoolProxy```, 使用风险由用户自行承担  
本程序运行需要联网下载最新的 ```KoolProxy``` 到内存中运行, 也正因此本程序大小可以忽略不计.  

简介
---

本软件包是 KoolProxy 的 LuCI 控制界面,

软件包文件结构:
```
/
├── etc/
│   ├── config/
│   │   └── koolproxy                            // UCI 配置文件
│   │── init.d/
│   │   └── koolproxy                            // init 脚本
│   ├── koolproxy
│   │   ├── firewall.include                     // firewall 脚本
│   └── uci-defaults/
│       └── luci-koolproxy                       // uci-defaults 脚本
└── usr/
    └── lib/
        └── lua/
            └── luci/                            // LuCI 部分
                ├── controller/
                │   └── koolproxy.lua            // LuCI 菜单配置
                ├── i18n/                        // LuCI 语言文件目录
                │   └── koolproxy.zh-cn.lmo
                └── model/
                    └── cbi/
                        └── koolproxy.lua         // LuCI 基本设置
```

依赖
---
软件包的正常使用需要依赖 ```wget, dnsmasq-full, iptables, ipset``` 和 [dnsmasq-extra][openwrt-dnsmasq-extra].  

预览
---
![preview](https://github.com/chenhw2/luci-app-koolproxy/blob/master/preview.png)

配置
---

软件包的配置文件路径: `/etc/config/koolproxy`  
此文件为 UCI 配置文件, 配置方式可参考 [Wiki -> Use-UCI-system][Use-UCI-system] 和 [OpenWrt Wiki][uci]  

编译
---

从 OpenWrt 的 [SDK][openwrt-sdk] 编译  
```bash
# 解压下载好的 SDK
tar xjf OpenWrt-SDK-ar71xx-for-linux-x86_64-gcc-4.8-linaro_uClibc-0.9.33.2.tar.bz2
cd OpenWrt-SDK-ar71xx-*
# Clone 项目
git clone https://github.com/chenhw2/luci-app-koolproxy.git package/feeds/luci-app-koolproxy
# 编译 po2lmo (如果有po2lmo可跳过)
pushd package/feeds/luci-app-koolproxy/tools/po2lmo
make && sudo make install
popd
# 选择要编译的包 LuCI -> 3. Applications
make menuconfig
# 开始编译
make package/feeds/luci-app-koolproxy/compile V=s
```

 [openwrt-sdk]: https://wiki.openwrt.org/doc/howto/obtain.firmware.sdk
 [Use-UCI-system]: https://github.com/shadowsocks/luci-app-shadowsocks/wiki/Use-UCI-system
 [uci]: https://wiki.openwrt.org/doc/uci
 [openwrt-dnsmasq-extra]: https://github.com/chenhw2/openwrt-dnsmasq-extra
 [koolshare]: http://koolshare.cn/thread-64086-1-1.html
