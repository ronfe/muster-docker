FROM centos

RUN curl -sL https://rpm.nodesource.com/setup | bash -
RUN yum install -y passwd sudo git nodejs wget tar
RUN npm install npm -g

RUN useradd master
RUN passwd -f -u master
RUN echo "master ALL=(ALL) ALL" >> /etc/sudoers

RUN su master
RUN cd ~

RUN git clone --recursive https://github.com/stevennuo/muster

RUN sudo npm install -g bower
RUN sudo npm install -g nodemon

## Compile ffmpeg
RUN export PATH=$PATH:$HOME/bin

RUN sudo yum install autoconf automake gcc gcc-c++ git libtool make nasm pkgconfig zlib-devel
RUN mkdir ~/ffmpeg_sources
RUN cd ~/ffmpeg_sources
RUN git clone --depth 1 https://github.com/yasm/yasm.git
RUN cd yasm
RUN autoreconf -fiv
RUN ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin"
RUN make
RUN make install
RUN make distclean

RUN cd ~/ffmpeg_sources
RUN git clone --depth 1 git://git.videolan.org/x264
RUN cd x264
RUN ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static
RUN sudo make
RUN sudo make install
RUN make distclean

RUN cd ~/ffmpeg_sources
RUN git clone --depth 1 https://github.com/Distrotech/fdk-aac.git
RUN cd fdk-aac
RUN autoreconf -fiv
RUN ./configure --prefix="$HOME/ffmpeg_build" --disable-shared
RUN make
RUN make install
RUN make distclean

RUN cd ~/ffmpeg_sources
RUN git clone --depth 1 https://github.com/rbrito/lame.git
RUN cd lame
RUN ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --disable-shared --enable-nasm
RUN make
RUN make install
RUN make distclean

RUN cd ~/ffmpeg_sources
RUN git clone --depth 1 https://github.com/justvanbloom/Opus.git
RUN cd Opus
RUN autoreconf -fiv
RUN ./configure --prefix="$HOME/ffmpeg_build" --disable-shared
RUN make
RUN make install
RUN make distclean

RUN cd ~/ffmpeg_sources
RUN curl -O http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.gz
RUN tar xzvf libogg-1.3.2.tar.gz
RUN cd libogg-1.3.2
RUN ./configure --prefix="$HOME/ffmpeg_build" --disable-shared
RUN make
RUN make install
RUN make distclean

RUN cd ~/ffmpeg_sources
RUN curl -O http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.4.tar.gz
RUN tar xzvf libvorbis-1.3.4.tar.gz
RUN cd libvorbis-1.3.4
RUN ./configure --prefix="$HOME/ffmpeg_build" --with-ogg="$HOME/ffmpeg_build" --disable-shared
RUN make
RUN make install
RUN make distclean

RUN cd ~/ffmpeg_sources
RUN git clone --depth 1 https://github.com/webmproject/libvpx.git
RUN cd libvpx
RUN ./configure --prefix="$HOME/ffmpeg_build" --disable-examples
RUN make
RUN make install
RUN make clean

RUN cd ~/ffmpeg_sources
RUN git clone --depth 1 https://github.com/FFmpeg/FFmpeg.git
RUN cd FFmpeg
RUN PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --extra-cflags="-I$HOME/ffmpeg_build/include" --extra-ldflags="-L$HOME/ffmpeg_build/lib" --bindir="$HOME/bin" --enable-gpl --enable-nonfree --enable-libfdk_aac --enable-libmp3lame --enable-libopus --enable-libvorbis --enable-libvpx --enable-libx264
RUN make
RUN make install
RUN make distclean
RUN hash -r

RUN mkdir ~/qrsync
RUN mkdir ~/qrsync/conf

RUN wget http://devtools.qiniu.io/qiniu-devtools-linux_amd64-current.tar.gz
RUN tar zxvf qiniu-devtools-linux_amd64-current.tar.gz -C ~/qrsync
