 # SPDX-License-Identifier: GPL-2.0-or-later
# Example Package 

PKG_NAME="xeeve"
PKG_VERSION="2.1.2"
PKG_SHA256="29acc4fa837db42d03791012a0b7dd9067b64f7e40faedb96ad3ee4281899cf7"
PKG_LICENSE="APL"
PKG_SITE="https://github.com/xteve-project/xTeVe"
PKG_URL="https://github.com/xteve-project/xTeVe/archive/2.1.2.0120.zip"
PKG_DEPENDS_TARGET="toolchain go:host"
PKG_SECTION="service/system"
PKG_DEPENDS_TARGET="toolchain libnetwork tini systemd"

PKG_LONGDESC="A CLI tool for spawning and running containers according to the OCI specification."
PKG_TOOLCHAIN="manual"
PKG_VERSION_NUMBER="1.0.0"
PKG_REV="123"
PKG_ARCH="any"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="service.xeeve"
PKG_ADDON_TYPE="xbmc.service"

# PKG_ADDON_REQUIRES="tools.ffmpeg-tools:0.0.0"
PKG_MAINTAINER="dbiesecke "

pre_make_target() {
  go_configure

  export LDFLAGS="-w -extldflags -static -X main.gitCommit=${PKG_GIT_COMMIT} -X main.version=$(cat ./VERSION) -extld $CC"

  mkdir -p ${GOPATH}
  if [ -d $PKG_BUILD/vendor ]; then
    mv $PKG_BUILD/vendor ${GOPATH}/src
  fi
  

  
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
  cd ..
  rm -fR xTeVe
  
  }

  
    
addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/
  cp -r $PKG_BUILD/* \
        -d $ADDON_BUILD/$PKG_ADDON_ID/

}

