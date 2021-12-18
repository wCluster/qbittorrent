# 第一重阶段：准备构建用的文件
FROM alpine:latest AS prepare

WORKDIR /
RUN wget https://github.com.cnpmjs.org/c0re100/qBittorrent-Enhanced-Edition/releases/download/release-4.3.9.10/qbittorrent-nox_x86_64-linux-musl_static.zip
RUN unzip qbittorrent-nox_x86_64-linux-musl_static.zip

# 第二重阶段：准备环境
FROM alpine:latest
WORKDIR /

EXPOSE 80

RUN mkdir -p /root/.config/qBittorrent/
COPY qBittorrent.conf /root/.config/qBittorrent/qBittorrent.conf

COPY entry.sh /entry.sh
RUN chmod 777 /entry.sh
ENTRYPOINT ["/entry.sh"]

COPY --from=prepare /qbittorrent-nox /

VOLUME ["/data"]