# 第一重阶段：准备构建用的文件
FROM alpine:latest AS prepare

WORKDIR /
RUN apk add curl wget
RUN curl https://api.github.com/repos/c0re100/qBittorrent-Enhanced-Edition/releases/latest | grep "/qbittorrent-enhanced-nox_x86_64-linux-musl_static.zip" | cut -d : -f 2,3 | tr -d \" | wget -qi - -O q.zip
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
