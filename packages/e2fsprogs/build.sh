TERMUX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"

TERMUX_PKG_HOMEPAGE=http://e2fsprogs.sourceforge.net
TERMUX_PKG_DESCRIPTION="Ext2/3/4 filesystem utilities"
TERMUX_PKG_VERSION=1.44.2
TERMUX_PKG_SRCURL=https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v${TERMUX_PKG_VERSION}/e2fsprogs-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=8324cf0b6e81805a741d94087b00e99f7e16144f1ee5a413709a1fa6948b126c
TERMUX_PKG_CONFFILES="etc/mke2fs.conf"
TERMUX_PKG_DEPENDS="libuuid"

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--sbindir=${TERMUX_PREFIX}/bin
--enable-symlink-install
--enable-relative-symlinks
--disable-defrag
--disable-e2initrd-helper
--disable-libuuid
--disable-uuidd
"
