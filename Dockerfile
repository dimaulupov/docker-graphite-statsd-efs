FROM hopsoft/graphite-statsd

RUN apt-get -y update \
 && apt-get -y install nfs-common \
 && mkdir /efs \
 && mkdir /originals

# Dirs inside efs do not exist yet, we need to set aside our working dirs so the entrypoint can move them into place

RUN for p in /opt/graphite /opt/statsd ; do \
    mv $p /originals/; ln -sf /efs$p $p; done

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
