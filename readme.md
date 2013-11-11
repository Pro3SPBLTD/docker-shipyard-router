# Shipyard App Router

This provides the Shipyard Application Router for production deployment.  It uses
the Hipache application from Docker.

* `docker build -t shipyard-router .`
* `docker run shipyard-router`

Ports

* 80

Environment Variables

* `ROUTER_WORKERS`: Number of workers (default: 5)
* `ROUTER_MAX_SOCKETS`: Maximum number of sockets (default: 100)
* `ROUTER_DEAD_BACKEND_TTL`: Number of seconds before backend is labeled dead
* `ROUTER_HTTP_PORT`: Listen port (default: 80)
* `REDIS_HOST`: Shipyard Redis Host
* `REDIS_PORT`: Shipyard Redis Port
