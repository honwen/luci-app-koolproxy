local fs = require "nixio.fs"
local userrules = "/etc/koolproxy/user.txt"

f = SimpleForm("User.txt", "%s %s" %{translate("User Custom"), translate("Rules")})

t = f:field(TextValue, "conf")
t.rmempty = true
t.rows = 30
function t.cfgvalue()
	return fs.readfile(userrules) or ""
end

function f.handle(self, state, data)
	if state == FORM_VALID then
		if data.conf then
			fs.writefile(userrules, data.conf:gsub("\r\n", "\n"))
			luci.sys.call("/etc/init.d/koolproxy restart")
		end
	end
	return true
end

return f