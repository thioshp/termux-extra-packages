TERMUX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"

TERMUX_PKG_HOMEPAGE=https://xorg.freedesktop.org/
TERMUX_PKG_DESCRIPTION="X11 Session Management library"
TERMUX_PKG_VERSION=1.2.2
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libSM-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=0baca8c9f5d934450a70896c4ad38d06475521255ca63b717a6510fdb6e287bd
TERMUX_PKG_DEPENDS="libice"
TERMUX_PKG_BUILD_DEPENDS="xorg-util-macros, xtrans"
TERMUX_PKG_DEVPACKAGE_DEPENDS="xtrans"
