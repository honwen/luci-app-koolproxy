-- Copyright (C) 2016 chenhw2 <https://github.com/chenhw2>
-- Licensed to the public under the MIT License.

module("luci.controller.koolproxy", package.seeall)

function index()
	entry({"admin", "services", "koolproxy"},
		alias("admin", "services", "koolproxy", "general"),
		_("KoolProxy"), 50)

	entry({"admin", "services", "koolproxy", "general"},
		cbi("koolproxy"), _("General Settings"), 20).leaf = true

	entry({"admin", "services", "koolproxy", "log"},
		call("action_log"), _("System Log"), 30).leaf = true
end

function action_log()
	local fs = require "nixio.fs"
	local conffile = "/var/log/koolproxy_watchdog.log"
	local watchdog = fs.readfile(conffile) or ""
	luci.template.render("admin_status/syslog", {syslog=watchdog})
end
