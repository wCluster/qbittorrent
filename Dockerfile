# 第一重阶段：准备构建用的文件
FROM alpine:latest AS prepare

WORKDIR /
RUN wget -O q.zip https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases/download/release-4.4.2.10/qbittorrent-enhanced-nox_x86_64-linux-musl_static.zip
RUN unzip q.zip 

# 第二重阶段：准备环境
FROM alpine:latest

WORKDIR /

EXPOSE 80

RUN mkdir -p /root/.config/qBittorrent/
COPY qBittorrent.conf /root/.config/qBittorrent/qBittorrent.conf
COPY entrypoint.sh /entrypoint.sh
COPY --from=prepare /qbittorrent-nox /

VOLUME ["/data"]
CMD ["/entrypoint.sh"]
