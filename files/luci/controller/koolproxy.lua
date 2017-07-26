module("luci.controller.koolproxy", package.seeall)

function index()
  entry(
    {"admin", "services", "koolproxy"},
    cbi("koolproxy"), _("KoolProxy"), 55)
end
