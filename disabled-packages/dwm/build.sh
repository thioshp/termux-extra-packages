TERMUX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"

TERMUX_PKG_HOMEPAGE=http://dwm.suckless.org
TERMUX_PKG_DESCRIPTION="A dynamic window manager for X"
TERMUX_PKG_VERSION=6.1
TERMUX_PKG_REVISION=2
TERMUX_PKG_SRCURL=http://dl.suckless.org/dwm/dwm-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=c2f6c56167f0acdbe3dc37cca9c1a19260c040f2d4800e3529a21ad7cce275fe
TERMUX_PKG_DEPENDS="dmenu, freetype, libx11, libxinerama, libxft, st, xorg-fonts-75dpi | xorg-fonts-100dpi"
TERMUX_PKG_BUILD_IN_SRC=true
