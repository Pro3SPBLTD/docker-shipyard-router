#!/bin/bash
REDIS_HOST=${REDIS_PORT_6379_TCP_ADDR:-$REDIS_HOST}
REDIS_HOST=${REDIS_HOST:-127.0.0.1}
REDIS_PORT=${REDIS_PORT_6379_TCP_PORT:-$REDIS_PORT}
REDIS_PORT=${REDIS_PORT:-6379}
ROUTER_CONFIG=/etc/shipyard_router.config.json
ROUTER_WORKERS=${ROUTER_WORKERS:-5}
ROUTER_MAX_SOCKETS=${ROUTER_MAX_SOCKETS:-100}
ROUTER_DEAD_BACKEND_TTL=${ROUTER_DEAD_BACKEND_TTL:-30}
ROUTER_HTTP_PORT=${ROUTER_HTTP_PORT:-80}
LOG_DIR=/var/log/shipyard
mkdir -p $LOG_DIR

# check for fig env
if [ ! -z "$REDIS_1_PORT_6379_TCP_ADDR" ]; then
    REDIS_HOST=$REDIS_1_PORT_6379_TCP_ADDR
    REDIS_PORT=$REDIS_1_PORT_6379_TCP_PORT
fi
# hipache config
cat << EOF > $ROUTER_CONFIG
{
    "server": {
        "accessLog": "/var/log/shipyard/router.log",
        "port": $ROUTER_HTTP_PORT,
        "workers": $ROUTER_WORKERS,
        "maxSockets": $ROUTER_MAX_SOCKETS,
        "deadBackendTTL": $ROUTER_DEAD_BACKEND_TTL
    },
    "redisHost": "$REDIS_HOST",
    "redisPort": $REDIS_PORT
}
EOF
# run
hipache -c $ROUTER_CONFIG
