FROM ubuntu:16.04
MAINTAINER Yu You <youyu.youyu@gmail.com>

# Add local bin to path
ENV PATH /usr/local/bin:$PATH

# Get dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  cmake \
  graphviz \
  git \
  gcc-4.8 \
  gcc-4.8-multilib \
  libpng-dev \
  libjpeg-dev \
  libtiff-dev \
  libxxf86vm1 \
  libxxf86vm-dev \
  libxi-dev \
  libxrandr-dev \
  python-dev \
  python-pip \
  nano \
&& cd /opt \
&& git clone https://github.com/openMVG/openMVG.git \
&& cd openMVG && git checkout develop && git submodule init && git submodule update \
&& cd /opt/ && mkdir openMVG_Build && cd openMVG_Build \
&& cmake -DCMAKE_BUILD_TYPE=RELEASE -DOpenMVG_BUILD_TESTS=ON -DOpenMVG_BUILD_EXAMPLES=ON . ../openMVG/src/ && make -j 4  \
&& make install \
&& rm -rf /opt/* \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Clone the openvMVG repo
RUN git clone https://github.com/openMVG/openMVG.git \
&& cd openMVG && git checkout develop && git submodule init && git submodule update \
&& cd /opt/ && mkdir openMVG_Build && cd openMVG_Build \
&& cmake -DCMAKE_BUILD_TYPE=RELEASE -DOpenMVG_BUILD_TESTS=ON -DOpenMVG_BUILD_EXAMPLES=ON . ../openMVG/src/ && make -j \
&& make install \
# copy pano converter as well
&& cp ./Linux-x86_64-RELEASE/openMVG_sample_pano_converter /usr/local/bin/openMVG_sample_pano_converter
# Clean OpenMVG src and build
#&& rm -rf /opt/*

#WORKDIR  /opt
