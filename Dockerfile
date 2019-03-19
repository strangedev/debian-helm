FROM debian
RUN mkdir out
WORKDIR /build
COPY buildenv .
CMD ./build.sh