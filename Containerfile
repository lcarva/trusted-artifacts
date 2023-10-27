FROM registry.access.redhat.com/ubi9:latest as builder

RUN mkdir -p /mnt/rootfs
RUN dnf install --installroot /mnt/rootfs \
    bash coreutils gzip tar \
    --nodocs -y --setopt install_weak_deps=false
RUN dnf --installroot /mnt/rootfs clean all
RUN rm -rf /mnt/rootfs/var/cache/* /mnt/rootfs/var/log/dnf* /mnt/rootfs/var/log/yum.*

FROM scratch

COPY --from=builder /mnt/rootfs/ /

COPY scripts /usr/local/bin/