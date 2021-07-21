#! /bin/bash

# Here is where you run the secure service you want to run.  Do not exit.  Run in foreground.
# Overwrite this file in your docker image.  It is run as docker_user and docker_group.

#trap : TERM INT; sleep infinity & wait


CONFFILE=/etc/privoxy/config
PIDFILE=/config/privoxy.pid


if [ ! -f "${CONFFILE}" ]; then
	echo "Configuration file ${CONFFILE} not found!"
	exit 1
fi

/usr/sbin/privoxy --no-daemon --pidfile "${PIDFILE}" "${CONFFILE}"
