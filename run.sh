#!/bin/sh
# Check for $CLIENT_URLS
if [ -z ${CLIENT_URLS+x} ]; then
        CLIENT_URLS="http://etcd:4001,http://etcd:2379"
        echo "Using default CLIENT_URLS ($CLIENT_URLS)"
else
        echo "Detected new CLIENT_URLS value of $CLIENT_URLS"
fi

# Check for $PEER_URLS
if [ -z ${PEER_URLS+x} ]; then
        PEER_URLS="http://etcd:7001,http://etcd:2380"
        echo "Using default PEER_URLS ($PEER_URLS)"
else
        echo "Detected new PEER_URLS value of $PEER_URLS"
fi

ETCD_CMD="/bin/etcd --data-dir=/data --listen-peer-urls=${PEER_URLS} --listen-client-urls=${CLIENT_URLS} --advertise-client-urls=http://etcd:2379,http://etcd:4001 $*"
echo -e "Running '$ETCD_CMD'\nBEGIN ETCD OUTPUT\n"

exec $ETCD_CMD
