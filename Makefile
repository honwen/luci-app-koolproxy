#
# Copyright (C) 2016 chenhw2 <chenhw2@github.com>
#
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-koolproxy
PKG_VERSION:=0.1.3
PKG_RELEASE:=1

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=chenhw2 <chenhw2@github.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-koolproxy
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI Support for KoolProxy
	PKGARCH:=all
	DEPENDS:=+wget +ipset
endef

define Package/luci-app-koolproxy/description
	LuCI Support for KoolProxy.
endef

define Build/Prepare
	$(foreach po,$(wildcard ${CURDIR}/files/luci/i18n/*.po), \
		po2lmo $(po) $(PKG_BUILD_DIR)/$(patsubst %.po,%.lmo,$(notdir $(po)));)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-koolproxy/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	if [ -f /etc/uci-defaults/luci-koolproxy ]; then
		( . /etc/uci-defaults/luci-koolproxy ) && \
		rm -f /etc/uci-defaults/luci-koolproxy
	fi
	rm -rf /tmp/luci-indexcache /tmp/luci-modulecache
fi
exit 0
endef

define Package/luci-app-koolproxy/prerm
/etc/init.d/koolproxy stop
endef

define Package/luci-app-koolproxy/conffiles
/etc/config/koolproxy
/etc/koolproxy/user.txt
endef

define Package/luci-app-koolproxy/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/koolproxy.*.lmo $(1)/usr/lib/lua/luci/i18n/
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/luci/controller/*.lua $(1)/usr/lib/lua/luci/controller/
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DATA) ./files/luci/model/cbi/*.lua $(1)/usr/lib/lua/luci/model/cbi/
	$(INSTALL_DIR) $(1)/etc/koolproxy
	$(INSTALL_DATA) ./files/root/etc/koolproxy/{firewall.include,user.txt} $(1)/etc/koolproxy/
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/root/etc/config/koolproxy $(1)/etc/config/koolproxy
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/root/etc/init.d/koolproxy $(1)/etc/init.d/koolproxy
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/root/etc/uci-defaults/luci-koolproxy $(1)/etc/uci-defaults/luci-koolproxy

endef

$(eval $(call BuildPackage,luci-app-koolproxy))
