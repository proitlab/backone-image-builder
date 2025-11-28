# backone-image-builder
## Nexus Pro + NX-6

## To building up custom image from OpenWrt

/www/luci-static/resources/view/status/include/10_system.js -> Firmware Version
/usr/share/ucode/luci/template/themes/material/footer.ut -> Footer luci
/etc/backone-release -> Model and Board Name
/etc/rc.local -> Model and Board Name
/usr/share/luci/menu.d/luci-base.json -> Add menu SDWAN
/etc/opkg/distfeeds.conf -> Custom Repo


# Compile option in make menuconfig
    Check make_menuconfig.png

# Installer
- Install with Image Builder 23.05.2
- Use custom repo for nexus and netify packages
