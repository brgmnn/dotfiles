#!/bin/bash

sourcepath=$HOME/ffmpeg_source
buildpath=$HOME/ffmpeg_build

mkdir $sourcepath
mkdir $buildpath

function get_prerequisites() {
    #if test -n .hasprereqs
    sudo apt-get install libtool autoconf gperf pkg-config yasm
}

function get_expat() {
    #http://sourceforge.net/projects/expat/files/latest/download
    git clone git://github.com/cgwalters/expat-git-mirror expat
}

function get_freetype() {
    git clone git://git.sv.nongnu.org/freetype/freetype2.git
}

function get_fontconfig() {
    git clone git://anongit.freedesktop.org/fontconfig
}

function get_ffmpeg() {
    pushd $sourcepath
    git clone git://github.com/FFmpeg/FFmpeg
    popd
}

function build_freetype() {
    pushd $sourcepath/freetype2
    ./autogen.sh
    ./configure --disable-shared --enable-static --prefix=$buildpath
    make -j
    make install
    popd
}

function build_fontconfig() {
    pushd $sourcepath/fontconfig
    PKG_CONFIG_PATH=$buildpath/lib/pkgconfig/ ./autogen.sh
    PKG_CONFIG_PATH=$buildpath/lib/pkgconfig/ ./configure --disable-shared --enable-static --prefix=$buildpath
    make -j
    make install
    popd
}

function build_ffmpeg() {
    #todo: limit -j so we don't run out of RAM
    pushd $sourcepath/FFmpeg
    ./configure --prefix=$buildpath/ffmpeg_build --extra-cflags='-I$buildpath/include -static' --extra-ldflags='-L$buildpath/lib -static' --enable-static --disable-shared --disable-ffserver --disable-doc --pkg-config-flags='--static' #--enable-fontconfig
    make -j
}

get_prerequisites
get_expat
get_ffmpeg
get_freetype
get_fontconfig


#build_ffmpeg
#build_freetype
#build_fontconfig
