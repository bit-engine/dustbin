#!/bin/bash

dropdb "${DUSTBIN_DB_NAME}" &&
dropuser "${DUSTBIN_DB_USERNAME}" &&
echo "The database '${DUSTBIN_DB_NAME}' and role '${DUSTBIN_DB_USERNAME}' have been dropped."
