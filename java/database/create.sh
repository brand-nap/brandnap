#!/bin/bash
export PGPASSWORD='benperez10'
BASEDIR=$(dirname $0)
DATABASE=brandnap
psql -U postgres -f "$BASEDIR/dropdb.sql" &&
createdb -U postgres $DATABASE &&
psql -U postgres -d $DATABASE -f "$BASEDIR/schema.sql" &&
psql -U postgres -d $DATABASE -f "$BASEDIR/data.sql"
