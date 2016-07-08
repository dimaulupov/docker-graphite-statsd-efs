FROM hopsoft/graphite-statsd

RUN apt-get -y update \
 && apt-get -y install nfs-common \
 && mkdir /efs

# Dirs inside efs do not exist yet, we just need to point symlinks to them

#/opt/graphite, /opt/graphite/conf, /opt/graphite/storage, or /opt/statsd
RUN for p in /opt/graphite /opt/graphite/conf /opt/graphite/storage /opt/statsd ; do \
    rm -rf $p; ln -sf /efs/$p $p; done

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
