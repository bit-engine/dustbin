#!/bin/bash

psql -c "CREATE USER ${DUSTBIN_DB_USERNAME} WITH PASSWORD '${DUSTBIN_DB_PASSWORD}';" &&
createdb "${DUSTBIN_DB_NAME}" &&
psql -c "GRANT ALL PRIVILEGES ON DATABASE ${DUSTBIN_DB_NAME} to ${DUSTBIN_DB_USERNAME};" &&
echo "The database '${DUSTBIN_DB_NAME}' and role '${DUSTBIN_SB_USERNAME}' have been created."

