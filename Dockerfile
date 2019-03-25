FROM debian
RUN apt update -y && apt install -y curl && mkdir out
WORKDIR /build
COPY buildenv .
ENTRYPOINT ["./build.sh"]