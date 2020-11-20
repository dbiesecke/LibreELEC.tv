# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xeeve"
PKG_VERSION="2.1.2"
PKG_SHA256="29acc4fa837db42d03791012a0b7dd9067b64f7e40faedb96ad3ee4281899cf7"
PKG_LICENSE="APL"
PKG_REV="104"
PKG_ARCH="any"
PKG_SITE="https://github.com/xteve-project/xTeVe"
PKG_URL="https://github.com/xteve-project/xTeVe/archive/2.1.2.0120.zip"
PKG_DEPENDS_TARGET="toolchain go:host"
PKG_LONGDESC="M3U Proxy for Plex DVR and Emby Live TV."
PKG_TOOLCHAIN="manual"
PKG_SHORTDESC="A bundle of network tools and programs"
PKG_SECTION="virtual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="xTeVe M3U Proxy"
PKG_ADDON_TYPE="xbmc.service"
# PKG_ADDON_REQUIRES="tools.ffmpeg-tools:0.0.0"
PKG_MAINTAINER="dbiesecke "
# PKG_DEPENDS_TARGET="xteve"

pre_make_target() {
  go_configure

  export LDFLAGS="-w -extldflags -static -X main.gitCommit=${PKG_GIT_COMMIT} -X main.version=$(cat ./VERSION) -extld $CC"

  mkdir -p ${GOPATH}
  if [ -d $PKG_BUILD/vendor ]; then
    mv $PKG_BUILD/vendor ${GOPATH}/src
  fi
  
# 
#   test -d ${GOPATH}/src/github.com/xteve-project && rm -fR ${GOPATH}/src/github.com/xteve-project
  
#   test -d ${GOPATH}/src/github.com/xteve-project/xTeVe || mkdirmr -p ${GOPATH}/src/github.com/xteve-project
  
  
#   ln -fs $PKG_BUILD ${GOPATH}/src/github.com/xteve-project/xTeVe
  
}

make_target() {
  mkdir -p bin

# 	cd $GOPATH/src/xteve-project/xTeVe
	$GOLANG get github.com/koron/go-ssdp
	$GOLANG get github.com/gorilla/websocket
	$GOLANG get github.com/kardianos/osext
# 	$GOLANG get -d github.com/xteve-project/xTeVe  
	git clone https://github.com/xteve-project/xTeVe.git
	cd xTeVe && $GOLANG build -v -o ../bin/xteve -a -tags "cgo static_build" -ldflags "$LDFLAGS" xteve.go
# 	rm -fR xTeVe
	
# 	rm -fR $GOPATH/src/github.com/
  
  }

  
addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/
  cp -r $PKG_BUILD/* \
        -d $ADDON_BUILD/$PKG_ADDON_ID/

        
#   mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib
#   cp -L $(get_install_dir imagemagick)/usr/lib/libMagickCore-7.Q16HDRI.so.? \
#         $ADDON_BUILD/$PKG_ADDON_ID/lib/
#   cp -L $(get_install_dir imagemagick)/usr/lib/libMagickWand-7.Q16HDRI.so \
#         $ADDON_BUILD/$PKG_ADDON_ID/lib/CORE_RL_Wand_.so
}
