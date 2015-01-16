FROM ronfe/testsvr:latest

RUN su master
RUN cd ~

RUN git clone --recursive https://github.com/stevennuo/muster.git

## Compile ffmpeg
RUN export PATH=$PATH:$HOME/bin

RUN mkdir ~/ffmpeg_sources

RUN cd ~/ffmpeg_sources && \
    git clone --depth 1 https://github.com/yasm/yasm.git &&\
    cd yasm &&\
    autoreconf -fiv &&\
    ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" &&\
    make &&\
    make install &&\
    make distclean

RUN cd ~/ffmpeg_sources && \
    git clone --depth 1 http://git.videolan.org/git/x264.git && \
    cd x264 && \
    ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static && \
    make && \
    make install && \
    make distclean

RUN cd ~/ffmpeg_sources && \
    git clone --depth 1 https://github.com/Distrotech/fdk-aac.git && \
    cd fdk-aac && \
    autoreconf -fiv && \
    ./configure --prefix="$HOME/ffmpeg_build" --disable-shared && \
    make && \
    make install && \
    make distclean

RUN cd ~/ffmpeg_sources && \
    git clone --depth 1 https://github.com/rbrito/lame.git && \
    cd lame && \
    ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --disable-shared --enable-nasm && \
    make && \
    make install && \
    make distclean

RUN cd ~/ffmpeg_sources && \
    git clone --depth 1 https://github.com/justvanbloom/Opus.git && \
    cd Opus && \
    autoreconf -fiv && \
    ./configure --prefix="$HOME/ffmpeg_build" --disable-shared && \
    make && \
    make install && \
    make distclean

RUN cd ~/ffmpeg_sources && \
    curl -O http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.gz && \
    tar xzvf libogg-1.3.2.tar.gz && \
    cd libogg-1.3.2 && \
    ./configure --prefix="$HOME/ffmpeg_build" --disable-shared && \
    make && \
    make install && \
    make distclean

RUN cd ~/ffmpeg_sources && \
    curl -O http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.4.tar.gz && \
    tar xzvf libvorbis-1.3.4.tar.gz && \
    cd libvorbis-1.3.4 && \
    ./configure --prefix="$HOME/ffmpeg_build" --with-ogg="$HOME/ffmpeg_build" --disable-shared && \
    make && \
    make install && \
    make distclean

RUN cd ~/ffmpeg_sources && \
    git clone --depth 1 https://github.com/webmproject/libvpx.git && \
    cd libvpx && \
    ./configure --prefix="$HOME/ffmpeg_build" --disable-examples && \
    make && \
    make install && \
    make clean

RUN cd ~/ffmpeg_sources && \
    git clone --depth 1 https://github.com/FFmpeg/FFmpeg.git && \
    cd FFmpeg && \
    PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --extra-cflags="-I$HOME/ffmpeg_build/include" --extra-ldflags="-L$HOME/ffmpeg_build/lib" --bindir="$HOME/bin" --enable-gpl --enable-nonfree --enable-libfdk_aac --enable-libmp3lame --enable-libopus --enable-libvorbis --enable-libvpx --enable-libx264 && \
    make && \
    make install && \
    make distclean && \
    hash -r

RUN mkdir -p ~/qrsync/conf

RUN wget http://devtools.qiniu.io/qiniu-devtools-linux_amd64-current.tar.gz
RUN tar zxvf qiniu-devtools-linux_amd64-current.tar.gz -C ~/qrsync
