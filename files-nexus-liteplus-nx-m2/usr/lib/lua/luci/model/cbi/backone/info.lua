local fs = require "nixio.fs"
local conffile = "/tmp/backone.info"

f = SimpleForm("logview")

t = f:field(TextValue, "conf")
t.rmempty = true
t.rows = 30
function t.cfgvalue()
  luci.sys.exec("backone-cli info > /tmp/backone.info")
  luci.sys.exec("backone-cli listnetworks | grep zt >> /tmp/backone.info")
  luci.sys.exec("echo >> /tmp/backone.info")
  luci.sys.exec("backone-cli peers | grep -v peers | grep -v ztaddr >> /tmp/backone.info")
  luci.sys.exec("echo >> /tmp/backone.info")
  luci.sys.exec("netstat -nr >> /tmp/backone.info")
  -- luci.sys.exec("ifconfig $(ifconfig | grep zt | awk '{print $1}') >> /tmp/backone.info")
        return fs.readfile(conffile) or ""
end
t.readonly="readonly"

return f
