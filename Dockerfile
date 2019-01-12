FROM alpine
LABEL maintainer "syuchan1005 <syuchan.dev@gmail.com>"

RUN apk add build-base cmake git raspberrypi raspberrypi-dev raspberrypi-libs \
    && git clone https://github.com/Pulse-Eight/libcec.git \
    && cd /libcec && git submodule update --init \
    && cd src/platform \
    && mkdir build && cd build && cmake .. && make -j4 && make install \
    && cd /libcec \
    && mkdir build && cd build && cmake cmake -DRPI_INCLUDE_DIR=/opt/vc/include -DRPI_LIB_DIR=/opt/vc/lib -DCMAKE_INSTALL_PREFIX=/opt/libcec .. && make -j4 && make install

ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/vc/lib:/opt/libcec/lib" PATH="$PATH:/opt/libcec/bin"

CMD [ "cec-client", "-h" ]
