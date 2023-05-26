module("luci.controller.backone",package.seeall)

function index()
  if not nixio.fs.access("/etc/config/backone")then
return
end

entry({"admin","sdwan"}, firstchild(), "SDWAN", 45).dependent = false

entry({"admin", "sdwan", "backone"},firstchild(), _("BackOne")).dependent = false

entry({"admin", "sdwan", "backone", "log"},form("backone/info"), _("BackOne Info"), 2)

entry({"admin","sdwan","backone","status"},call("act_status"))
end

function act_status()
local e={}
  e.running=luci.sys.call("pgrep /usr/bin/backone >/dev/null")==0
  luci.http.prepare_content("application/json")
  luci.http.write_json(e)
end

