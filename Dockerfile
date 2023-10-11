FROM debian:bookworm

ARG MAKE_JOBS=2

WORKDIR /root

RUN apt-get update && \
    apt-get install --yes \
        git \
        build-essential \
        cmake \
        libjack-jackd2-dev \
        libsndfile1-dev \
        libfftw3-dev \
        libxt-dev \
        libavahi-client-dev \
        libasound2-dev \
        libudev-dev \
        sed

ENV SC_BRANCH=3.13

RUN git clone \
    --depth 1 \
    --branch $SC_BRANCH \
    --recurse-submodules \
    https://github.com/SuperCollider/SuperCollider.git && \
    cd SuperCollider && \
    mkdir -p /root/SuperCollider/build && \
    cd /root/SuperCollider/build && \
    cmake \
        -DCMAKE_BUILD_TYPE=Debug \
        -DSUPERNOVA=OFF \
        -DSC_ED=OFF \
        -DSC_EL=OFF \
        -DSC_VIM=ON \
        -DNATIVE=ON \
        -DSC_IDE=OFF \
        -DNO_X11=ON \
        -DSC_ABLETON_LINK=OFF \
        -DSC_QT=OFF .. && \
	cmake --build . --config Debug --target all -j${MAKE_JOBS} && \
    cmake --build . --config Debug --target install -j${MAKE_JOBS} && \
    rm -rf /root/SuperCollider

COPY custom.css .
COPY build_docs.scd .
COPY build_docs.sh .
