FROM centos

RUN curl -sL https://rpm.nodesource.com/setup | bash -
RUN yum install -y sudo passwd git nodejs wget tar sed
RUN yum install -y autoconf autoreconf automake gcc gcc-c++ git libtool make nasm pkgconfig zlib-devel
# RUN npm install npm -g

RUN npm install -g bower
RUN npm install -g nodemon

RUN useradd master
RUN passwd -f -u master
RUN echo "master ALL=(ALL) ALL" >> /etc/sudoers
RUN sed '/requiretty/d' /etc/sudoers
