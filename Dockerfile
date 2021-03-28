FROM debian:jessie-slim
RUN apt update -y
RUN apt install -y fuse libssl1.0.0 libssl-dev 
WORKDIR /app
COPY . .
RUN ./pkcmd-lx/pkcmd-lx-x86_64.AppImage --appimage-extract
COPY pkcmd-lx/PKPlusDeviceFile.dat squashfs-root/usr/bin/
RUN ln -s  squashfs-root/usr/bin/pkcmd-lx-x86_64 pkcmd-lx-x86_64
