#!/bin/bash
set -e

if [ "$1" = 'cabify' ]; then
	exec initctl start cabify
    # chown -R postgres "$PGDATA"

    # if [ -z "$(ls -A "$PGDATA")" ]; then
    #     gosu postgres initdb
    # fi

    # exec gosu postgres "$@"
fi

exec "$@"
