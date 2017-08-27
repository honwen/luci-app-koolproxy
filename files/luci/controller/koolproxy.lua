-- Copyright (C) 2016 chenhw2 <https://github.com/chenhw2>
-- Licensed to the public under the MIT License.

module("luci.controller.koolproxy", package.seeall)

function index()
	entry({"admin", "services", "koolproxy"},
		alias("admin", "services", "koolproxy", "general"),
		_("KoolProxy"), 50)

	entry({"admin", "services", "koolproxy", "general"},
		cbi("koolproxy-general"), _("General Settings"), 10).leaf = true

	entry({"admin", "services", "koolproxy", "custom"},
		cbi("koolproxy-custom"), _("User Custom"), 20).leaf = true

	entry({"admin", "services", "koolproxy", "log"},
		call("action_log"), _("System Log"), 30).leaf = true

	if luci.sys.call("command -v /etc/init.d/dnsmasq-extra >/dev/null") ~= 0 then
		return
	end

	entry({"admin", "services", "koolproxy", "kplist"},
		call("action_kplist"), _("KP-List"), 15).leaf = true

end

function action_log()
	local fs = require "nixio.fs"
	local conffile = "/var/log/koolproxy_watchdog.log"
	local watchdog = fs.readfile(conffile) or ""
	luci.template.render("admin_status/syslog", {syslog=watchdog})
end

function action_kplist()
	local fs = require "nixio.fs"
	local conffile = "/etc/dnsmasq-extra.d/koolproxy"
	local kplist = fs.readfile(conffile) or ""
	luci.template.render("/koolproxy/kplist", {kplist=kplist})
end
